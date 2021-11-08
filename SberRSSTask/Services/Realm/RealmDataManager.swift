//
//  RealmDataManager.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 08.11.2021.
//

import RealmSwift

class RealmDataManager {
    static let shared = RealmDataManager()
    
    private let realm = try! Realm()
    
    // MARK: - Lifecycle
    
    private init() {}
    
    // MARK: - Work With News
    
    func deleteNews(_ news: [FeedRealm]) {
        try! realm.write {
            realm.delete(news)
        }
    }
    
    func deleteAllNews() {
        let news = fetchNews()
        
        try! realm.write {
            realm.delete(news)
        }
    }
    
    func fetchNews() -> [FeedRealm] {
        return realm.objects(FeedRealm.self).compactMap { $0 }
    }
    
    func saveNewsArray(news: [FeedRealm]) {
        try! realm.write {
            realm.add(news)
        }
    }
    
    func createNews(news: FeedRealm) {
        try! realm.write {
            realm.add(news)
        }
    }
    
    func updateIsReading(news: FeedRealm) {
        try! realm.write {
            news.isReading = true
        }
    }
    
    // MARK: - Work With Sources
    func resetCurrentSourceStates(sources: [SourceRealm]) {
        try! realm.write {
            sources.indices.forEach { sources[$0].isCurrent = false }
        }
    }
    
    func updateIsCurrentSource(source: SourceRealm) {
        try! realm.write {
            source.isCurrent = true
        }
    }
    
    func getCurrentSource() -> SourceRealm? {
        if let currentSource = realm.objects(SourceRealm.self).filter("isCurrent = true").first {
            return currentSource
        } else {
            return nil
        }
    }
    
    func saveSources(sources: [SourceRealm]) {
        try! realm.write {
            realm.add(sources)
        }
    }
    
    func createSource(source: SourceRealm) {
        try! realm.write {
            realm.add(source)
        }
    }
    
    func deleteSource(_ source: SourceRealm) {
        try! realm.write {
            realm.delete(source)
        }
    }
    
    func loadSources() -> [SourceRealm] {
        let sources = realm.objects(SourceRealm.self).compactMap { $0 }
        if sources.isEmpty {
            let initialSources: [SourceRealm] = [
                SourceRealm(title: "Банки.ру", url: "https://www.banki.ru/xml/news.rss", isCurrent: true),
                SourceRealm(title: "Финам.RU", url: "https://www.finam.ru/net/analysis/conews/rsspoint", isCurrent: false)]
            return initialSources
        }
        return realm.objects(SourceRealm.self).compactMap { $0 }
    }
}
