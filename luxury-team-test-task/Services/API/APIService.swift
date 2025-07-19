//
//  APIService.swift
//  luxury-team-test-task
//
//  Created by Daniel Tvorun on 19/07/2025.
//

import Foundation

protocol APIService {

    func fetchStocks(_ completion: @escaping (Result<[StockModel], any Error>) -> Void)

}

// MARK: - APIService

extension APIServiceImplementation: APIService {

    func fetchStocks(_ completion: @escaping (Result<[StockModel], any Error>) -> Void) {
        request(
            endpoint: Constants.Endpoint.stocksJSON,
            responseType: [StockModel].self
        ) { result in
            completion(result)
        }
    }

}
