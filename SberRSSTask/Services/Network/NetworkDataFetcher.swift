//
//  NetworkDataFetcher.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 03.11.2020.
//

import Foundation

protocol NetworkDataFetcherProtocol {
    func fetchNewsData(sourceURL: String, completion: @escaping (Data?) -> ())
}

class NetworkDataFetcher: NetworkDataFetcherProtocol {
    
    private let networking: NetworkServiceProtocol
    
    init(networking: NetworkServiceProtocol = NetworkService()) {
        self.networking = networking
    }
    
    func fetchNewsData(sourceURL: String, completion: @escaping (Data?) -> ()) {
        
        
        networking.getNewsData(sourceURL: sourceURL) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure:
                completion(nil)
            }
        }
    }
}
