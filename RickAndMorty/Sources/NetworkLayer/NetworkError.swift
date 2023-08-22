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

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedToCreateRequest:
            return NSLocalizedString("Failed to create request.", comment: "")
        case .failedToGetData:
            return NSLocalizedString("Couldn't get data", comment: "")
        case .badUrl:
            return NSLocalizedString("Couldn't create request.", comment: "")
        }
    }
}
