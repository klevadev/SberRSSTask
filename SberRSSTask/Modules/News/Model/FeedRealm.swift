//
//  FeedRealm.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 08.11.2021.
//

import Foundation
import RealmSwift

class FeedRealm: Object {
    @Persisted var title: String = ""
    @Persisted var feedDescription: String?
    @Persisted var date: String = ""
    @Persisted var isReading: Bool = false
    
    convenience init(title: String, feedDescription: String, date: String) {
        self.init()
        self.title = title
        self.feedDescription = feedDescription
        self.date = date
    }
}
