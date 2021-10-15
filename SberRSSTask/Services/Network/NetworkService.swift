//
//  NetworkService.swift
//  SberRSSTask
//
//  Created by Lev Kolesnikov on 03.11.2020.
//

import Foundation

// MARK: - Network Layer

protocol NetworkServiceProtocol {
    func getNewsData(sourceURL: String, completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService: NetworkServiceProtocol {

    ///Получение тестовых данных
    ///
    /// - Parameters:
    ///     - completion: Блок кода который выполнится на главном потоке
    func getNewsData(sourceURL: String, completion: @escaping (Data?, Error?) -> Void) {

        guard let url = URL(string: sourceURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    ///Формирует необходимую задачу для запроса данных из сети
    ///
    /// - Parameters:
    ///     - request: Сформированный запрос в сеть
    ///     - completion: Блок кода который выполнится на главном потоке
    /// - Returns:
    ///     Возвращает сконфигурированную задачу для получения данных из сети
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, _, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}

