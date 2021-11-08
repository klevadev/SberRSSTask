//
//  RSSParser.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 03.11.2020.
//

import Foundation
import RealmSwift

class RSSParser: NSObject {

    private var feeds: [FeedRealm] = []
    private var elementName: String = String()
    private var feedTitle = String()
    private var feedDate = String()
    private var feedDescription = String()
    
    private let networkDataFetcher: NetworkDataFetcherProtocol = NetworkDataFetcher()
    
    func updateNews(currentSource: String, completion: @escaping ([FeedRealm]) -> Void) {
        feeds = []
        
        self.networkDataFetcher.fetchNewsData(sourceURL: currentSource) { [unowned self] (data) in
            guard let data = data else { return }
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
            completion(feeds)
        }
    }
}

extension RSSParser: XMLParserDelegate {

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if elementName == "item" {
            feedTitle = String()
            feedDate = String()
            feedDescription = String()
        }
        self.elementName = elementName
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        guard !data.isEmpty else { return }
        
        switch self.elementName {
        case "title":
            feedTitle += data
        case "pubDate":
            feedDate += data
        case "description":
            feedDescription += data
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let feed = FeedRealm(title: feedTitle, feedDescription: feedDescription, date: feedDate)
            RealmDataManager.shared.createNews(news: feed)
            feeds.append(feed)
        }
    }
}

