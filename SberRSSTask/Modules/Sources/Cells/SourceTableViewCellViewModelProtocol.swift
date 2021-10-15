//
//  SourceTableViewCellViewModel.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 03.11.2020.
//

protocol SourceTableViewCellViewModelProtocol: AnyObject {
    var title: String { get }
    var url: String { get }
    var isCurrent: Bool  { get }
}

class SourceTableViewCellViewModel: SourceTableViewCellViewModelProtocol {
    private var source: Source
    
    var title: String {
        return source.title
    }
    
    var url: String {
        return source.url
    }
    
    var isCurrent: Bool {
        return source.isCurrent
    }
    
    init (source: Source) {
        self.source = source
    }
}
