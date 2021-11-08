//
//  DetailsNewsViewModelProtocol.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 14.10.2021.
//

import Foundation


protocol DetailsNewsViewModelProtocol {
    var title: String { get }
    var description: String { get }
    var date: String { get }
    
    init(rssItem: FeedRealm)
}

class DetailsNewsViewModel: DetailsNewsViewModelProtocol {
    var title: String {
        rssItem.title
    }
    
    var description: String {
        removeHTMLTags(from: rssItem.feedDescription ?? "")
    }
    
    var date: String {
        rssItem.date.formattedDate
    }
    
    private let rssItem: FeedRealm
    
    required init(rssItem: FeedRealm) {
        self.rssItem = rssItem
    }
    
    private func removeHTMLTags(from str: String) -> String {
        let text = str
            .replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            .replacingOccurrences(of: "&[^;]+;", with:
                                    "", options:.regularExpression, range: nil)
        return text
    }
}
