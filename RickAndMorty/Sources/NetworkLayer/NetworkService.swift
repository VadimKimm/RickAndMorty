//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import Foundation

final class NetworkService {

    static let shared = NetworkService()

    private init() {}

    func execute(_ request: NetworkRequest, completion: @escaping () -> Void) {
        
    }
}
