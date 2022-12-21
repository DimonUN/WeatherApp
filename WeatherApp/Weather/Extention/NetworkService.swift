//
//  NetworkService.swift
//  Weather
//
//  Created by Дмитрий Никоноров on 09.09.2022.
//

import Foundation

enum NetworkErrors: Error {
    case `default`
    case serverError
    case parseError
    case unknownError
}

enum NetworkComponents {
    static let lat = "lat"
    static let lon = "lon"
    static let extra = "extra"
    static let extraValue = "true"
    static let getMethod = "GET"
}

protocol NetworkServiceProtocol {
    func request(url: URL, completion: @escaping (Result<Data, NetworkErrors>) -> Void)
    func request(url: URLRequest, completion: @escaping (Result<Data, NetworkErrors>) -> Void)
}

final class NetworkService {
    private let mainQueue = DispatchQueue.main
}

extension NetworkService: NetworkServiceProtocol {
    func request(url: URL, completion: @escaping (Result<Data, NetworkErrors>) -> Void) {

        let task = URLSession.shared.dataTask(with: url, completionHandler: {
            data, response, error in
            guard error == nil else {
                self.mainQueue.async { completion(.failure(.default)) }
                return
            }

            guard let data = data else {
                self.mainQueue.async { completion(.failure(.unknownError)) }
                return
            }

            self.mainQueue.async {
                completion(.success(data))
            }
        })
        task.resume()
    }

    func request(url: URLRequest, completion: @escaping (Result<Data, NetworkErrors>) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in

            guard error == nil else {
                self.mainQueue.async { completion(.failure(.default)) }
                return
            }

            guard let data = data else {
                self.mainQueue.async { completion(.failure(.unknownError)) }
                return
            }

            self.mainQueue.async {
                completion(.success(data))
            }
        })
        task.resume()
    }
}
