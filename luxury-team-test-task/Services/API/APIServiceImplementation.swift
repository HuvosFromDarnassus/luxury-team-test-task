//
//  APIServiceImplementation.swift
//  luxury-team-test-task
//
//  Created by Daniel Tvorun on 19/07/2025.
//

import Foundation

final class APIServiceImplementation {

    // MARK: Properties

    enum Constants {
        enum Endpoint {
            static let stocksJSON = "https://mustdev.ru/api/stocks.json"
        }
    }

    func request<R: Codable>(
        endpoint: String,
        responseType: R.Type,
        body: [String: Any] = [:],
        headers: [String: String] = [:],
        completion: @escaping (Result<R, Error>) -> Void
    ) {
        do {
            guard let url = URL(string: endpoint) else {
                completion(.failure(NetworkError.invalidURL))
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")

            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }

            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

            LogsService.network(body, data: nil)

            URLSession.shared.dataTask(with: request) { data, _, error in
                if let error = error {
                    LogsService.error("Request failed: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }

                guard let data else {
                    LogsService.error("Response data is nil")
                    DispatchQueue.main.async {
                        completion(.failure(NetworkError.emptyResponse))
                    }
                    return
                }

                LogsService.network(body, data: data)

                do {
                    let decoded = try JSONDecoder().decode(R.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(decoded))
                    }
                }
                catch {
                    LogsService.error("Decoding failed: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }

            }.resume()

        }
        catch {
            LogsService.error("Token fetch failed: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }

}

// MARK: Enums

enum NetworkError: Error {

    case invalidURL
    case emptyResponse

}
