//
//  NewsVCViewModel.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 03.11.2020.
//

import Foundation
import RealmSwift

protocol NewsVCViewModelProtocol: AnyObject {
    var news: [FeedRealm] { get set }
    var currentSource: SourceRealm { get set }
    func fetchNewsFromInternet(completion: @escaping() -> Void)
    func fetchNewsFromRealm()
    func saveNewsToRealm()
    func getNumberOfRows() -> Int
    func cellViewModel(forIndexPath: IndexPath) -> NewsTableViewCellViewModelProtocol
    func viewModelForSelectedRow(at indexPath: IndexPath) -> DetailsNewsViewModelProtocol
}

class NewsVCViewModel: NewsVCViewModelProtocol {
    private let rssParser: RSSParser = RSSParser()
    
    var news: [FeedRealm] = []
    // TO DO: - Брать текущий Source из realm
    var currentSource: SourceRealm = SourceRealm(title: "Банки.РУ", url: "https://www.banki.ru/xml/news.rss", isCurrent: true)
    
    func fetchNewsFromInternet(completion: @escaping () -> Void) {
        news = []
        RealmDataManager.shared.deleteAllNews()

        rssParser.updateNews(currentSource: currentSource.url) { [unowned self] news in

            self.news = news
            saveNewsToRealm()

            completion()
        }
    }
    
    func fetchNewsFromRealm() {
        let news = RealmDataManager.shared.fetchNews()
        self.news = news
    }
    
    func saveNewsToRealm() {
        RealmDataManager.shared.saveNewsArray(news: news)
    }
    
    func getNumberOfRows() -> Int {
        return news.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> NewsTableViewCellViewModelProtocol {
        NewsTableViewCellViewModel(feed: news[indexPath.row])
    }
    
    func viewModelForSelectedRow(at indexPath: IndexPath) -> DetailsNewsViewModelProtocol {
        DetailsNewsViewModel(rssItem: news[indexPath.row])
    }
}
