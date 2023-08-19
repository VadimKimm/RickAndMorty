//
//  NetworkRequest.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import Foundation

final class NetworkRequest {

    private let baseUrl = "https://rickandmortyapi.com/api/"
    private let endpoint: NetworkEndpoint
    private let pathComponents: [String]
//    private let queryParameters: [URLQueryItem]

    private var urlString: String {
        var string = baseUrl + endpoint.rawValue

        if !pathComponents.isEmpty {
            pathComponents.forEach {
                string += "/\($0)"
            }
        }

//        if !queryParameters.isEmpty {
//            string += "?"
//            let argumentString = queryParameters
//                .compactMap {
//                    guard let value = $0.value else { return nil }
//                    return "\($0.name)=\(value)"
//                }
//                .joined(separator: "&")
//            string += argumentString
//        }

        return baseUrl + endpoint.rawValue
    }

    public var url: URL? { URL(string: urlString) }

    public let httpMethod = "GET"

    init(
        endpoint: NetworkEndpoint,
        pathComponents: [String] = []
//        queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
//        self.queryParameters = queryParameters
    }
}

extension NetworkRequest {
    static let listCharacters = NetworkRequest(endpoint: .character)
}
