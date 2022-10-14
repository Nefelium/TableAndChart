//
//  NetworkManager.swift
//  TableAndChart
//
//  Created by Mikhail on 09.10.2022.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<PointsAPI> { get }

    func getPoints(count: Int, completion: @escaping (Result<Points, Error>) -> ())
}

class NetworkManager: Networkable {
    var provider = MoyaProvider<PointsAPI>(plugins: [NetworkLoggerPlugin()])
    
    func getPoints(count: Int, completion: @escaping (Result<Points, Error>) -> ()) {
        request(target: .getPoints(count: count), completion: completion)
    }
}

private extension NetworkManager {
    private func request<T: Decodable>(target: PointsAPI, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
