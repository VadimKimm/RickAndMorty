//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import Foundation

protocol NetworkServiceType {
    func execute<T: Codable>(
        _ request: NetworkRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    )
}

final class NetworkService: NetworkServiceType {

    static let shared = NetworkService()

    private init() {}

    public func execute<T: Codable>(
        _ request: NetworkRequest,
        expecting type: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let urlrequest = self.request(from: request) else {
            completion(.failure(NetworkError.failedToCreateRequest))
            return
        }

        let task = URLSession.shared.dataTask(with: urlrequest) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NetworkError.failedToGetData))
                return
            }

            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }

    private func request(from networkRequest: NetworkRequest) -> URLRequest? {
        guard let url = networkRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = networkRequest.httpMethod
        return request
    }
}
