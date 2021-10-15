//
//  UserDataManager.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 02.11.2020.
//

import Foundation

struct UserDataManager {
    static let (sourceTitleKey, sourceURLKey) = ("sourceTitle", "sourceURL")
    static let userSessionKey = "FeedNews"
    private static let userDefault = UserDefaults.standard
    
    struct UserDetails {
        var savedSourcesTitle: [String]
        var savedSourcesURL: [String]
        
        init(_ json: [String: [String]]) {
            
            self.savedSourcesTitle = json[sourceTitleKey] ?? ["Банки.ру", "Финам.RU"]
            
            self.savedSourcesURL = json[sourceURLKey] ?? ["https://www.banki.ru/xml/news.rss", "https://www.finam.ru/net/analysis/conews/rsspoint"]
        }
    }
    
    static func saveSources(sourcesTitle: [String], sourcesURL: [String]) {
        userDefault.set([sourceTitleKey: sourcesTitle, sourceURLKey: sourcesURL], forKey: userSessionKey)
    }
    
    static func getSourcesTitle() -> [String] {
        let value = UserDetails((userDefault.value(forKey: userSessionKey) as? [String: [String]]) ?? [:])
        return value.savedSourcesTitle
    }

    static func getSourcesURL() -> [String] {
        let value = UserDetails((userDefault.value(forKey: userSessionKey) as? [String: [String]]) ?? [:])
        return value.savedSourcesURL
    }
    static func clearUserData() {
        userDefault.removeObject(forKey: userSessionKey)
    }
}

