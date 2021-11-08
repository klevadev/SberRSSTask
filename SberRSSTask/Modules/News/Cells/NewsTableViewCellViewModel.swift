//
//  NewsTableViewCellViewModel.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 03.11.2020.
//

import Foundation

protocol NewsTableViewCellViewModelProtocol: AnyObject {
    var title: String { get }
    var date: String { get }
    var isReading: Bool  { get }
}

class NewsTableViewCellViewModel: NewsTableViewCellViewModelProtocol {
    
    private var feed: FeedRealm
    
    var title: String {
        return feed.title
    }
    
    var date: String {
        return feed.date.formattedDate
    }
    
    var isReading: Bool {
        return feed.isReading
    }
    
    init (feed: FeedRealm) {
        self.feed = feed
    }
}
