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
