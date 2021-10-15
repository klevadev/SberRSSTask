//
//  NewsVCViewModel.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 03.11.2020.
//

import Foundation

protocol NewsVCViewModelProtocol: AnyObject {
    var news: [Feed] { get set }
    var currentSource: Source { get set }
    func fetchNewsFromInternet(completion: @escaping() -> Void)
    func fetchNewsFromCoreData()
    func saveNewsToCoreData()
    func getNumberOfRows() -> Int
    func cellViewModel(forIndexPath: IndexPath) -> NewsTableViewCellViewModelProtocol
    func viewModelForSelectedRow(at indexPath: IndexPath) -> DetailsNewsViewModelProtocol
}

class NewsVCViewModel: NewsVCViewModelProtocol {
    private let rssParser: RSSParser = RSSParser()
    
    var news: [Feed] = []
    var currentSource: Source = Source(title: "Банки.РУ", url: "https://www.banki.ru/xml/news.rss")
    
    func fetchNewsFromInternet(completion: @escaping () -> Void) {
        news = []
        rssParser.updateNews(currentSource: currentSource.url) { [unowned self] news in
            self.news = news
            self.saveNewsToCoreData()
            completion()
        }
    }
    
    func fetchNewsFromCoreData() {
        guard let news = CoreDataManager.shared.loadNews() else { return }
        self.news = news
    }
    
    func saveNewsToCoreData() {
        CoreDataManager.shared.saveNews(news: news)
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
