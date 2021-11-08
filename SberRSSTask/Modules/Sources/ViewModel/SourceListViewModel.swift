//
//  SourceListViewModel.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 03.11.2020.
//

import Foundation

protocol SourceListViewModelProtocol {
    var sources: [SourceRealm] { get set }
    var currentSource: SourceRealm? { get set }
    
    func getNumberOfRows() -> Int
    func cellViewModel(forIndexPath: IndexPath) -> SourceTableViewCellViewModelProtocol?
    func saveSourcesToRealm()
    func loadSourcesFromRealm()
    func createNewSource(title: String, url: String, isCurrent: Bool)
    func removeSource(at row: Int)
}

class SourceListViewModel: SourceListViewModelProtocol {
    var sources: [SourceRealm] = []
    
    var currentSource: SourceRealm?
    
    func getNumberOfRows() -> Int {
        return sources.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> SourceTableViewCellViewModelProtocol? {
        SourceTableViewCellViewModel(source: sources[indexPath.row])
    }
    
    func saveSourcesToRealm() {
        RealmDataManager.shared.saveSources(sources: sources)
    }
    
    func loadSourcesFromRealm() {
        let sources = RealmDataManager.shared.loadSources()
        self.sources = sources
    }
    
    func createNewSource(title: String, url: String, isCurrent: Bool) {
        let newSource = SourceRealm(title: title, url: url, isCurrent: true)
        currentSource = newSource
        RealmDataManager.shared.resetCurrentSourceStates(sources: sources)
        
        RealmDataManager.shared.createSource(source: newSource)
        self.sources.append(newSource)
    }
    
    func removeSource(at row: Int) {
        RealmDataManager.shared.deleteSource(sources[row])
        self.sources.remove(at: row)
    }
}

