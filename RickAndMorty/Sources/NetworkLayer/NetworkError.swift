//
//  NetworkError.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import Foundation

enum NetworkError: Error {
    case failedToCreateRequest
    case failedToGetData
    case badUrl
}

// MARK: - LocalizedError

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedToCreateRequest:
            return NSLocalizedString("networkError.failedToCreateRequest", comment: "")
        case .failedToGetData:
            return NSLocalizedString("networkError.failedToGetData", comment: "")
        case .badUrl:
            return NSLocalizedString("networkError.badUrl", comment: "")
        }
    }
}
