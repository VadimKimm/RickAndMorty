//
//  NetworkRequest.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import Foundation

final class NetworkRequest {

    // MARK: - Properties

    public var url: URL? { URL(string: urlString) }
    public let httpMethod = "GET"

    private let endpoint: NetworkEndpoint
    private let pathComponents: [String]
    private let queryParameters: [URLQueryItem]

    private var urlString: String {
        var string = Constants.baseUrl + endpoint.rawValue

        if !pathComponents.isEmpty {
            pathComponents.forEach {
                string += "/\($0)"
            }
        }

        if !queryParameters.isEmpty {
            string += "?"
            let argumentString = queryParameters
                .compactMap {
                    guard let value = $0.value else { return nil }
                    return "\($0.name)=\(value)"
                }
                .joined(separator: "&")
            string += argumentString
        }

        return string
    }

    // MARK: - Initialization

    init(
        endpoint: NetworkEndpoint,
        pathComponents: [String] = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }

    convenience init?(urlString: String) {
        guard urlString.contains(Constants.baseUrl) else { return nil }
        let trimmed = urlString.replacingOccurrences(of: Constants.baseUrl, with: "")

        if trimmed.contains("/") {
            let components = trimmed.components(separatedBy: "/")
            guard !components.isEmpty else { return nil }

            let endpointString = components[0]
            if let endpoint = NetworkEndpoint(rawValue: endpointString) {
                let pathComponents = Array(components.dropFirst())
                self.init(endpoint: endpoint, pathComponents: pathComponents)
                return
            }
        } else if trimmed.contains("?") {
            let components = trimmed.components(separatedBy: "?")
            guard !components.isEmpty, components.count >= 2 else { return nil }

            let endpointString = components[0]
            let queryItemString = components[1]

            let queryItems: [URLQueryItem] = queryItemString.components(separatedBy: "&").compactMap {
                guard $0.contains("=") else { return nil }
                let parts = $0.components(separatedBy: "=")
                return URLQueryItem(name: parts[0], value: parts[1])
            }

            if let endpoint = NetworkEndpoint(rawValue: endpointString) {
                self.init(endpoint: endpoint, queryParameters: queryItems)
                return
            }
        }
        return nil
    }

}

// MARK: - Constants

extension NetworkRequest {
    enum Constants {
        static let baseUrl = "https://rickandmortyapi.com/api/"
    }
}

// MARK: - Template requests

extension NetworkRequest {
    static let listCharacters = NetworkRequest(endpoint: .character)
}
