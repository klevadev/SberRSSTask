//
//  NetworkService.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 03.11.2020.
//

import Foundation
import Alamofire

// MARK: - Network Layer

protocol NetworkServiceProtocol {
    func getNewsData(sourceURL: String, completion: @escaping (Result<Data, Error>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {

    ///Получение тестовых данных
    ///
    /// - Parameters:
    ///     - completion: Блок кода который выполнится на главном потоке
    func getNewsData(sourceURL: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        AF.request(sourceURL)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}

