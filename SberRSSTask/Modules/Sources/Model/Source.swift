//
//  Source.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 03.11.2020.
//

import RealmSwift

class SourceRealm: Object {
    @Persisted var title: String = ""
    @Persisted var url: String = ""
    @Persisted var isCurrent: Bool = false
    
    convenience init(title: String, url: String, isCurrent: Bool) {
        self.init()
        self.title = title
        self.url = url
        self.isCurrent = isCurrent
    }
}
