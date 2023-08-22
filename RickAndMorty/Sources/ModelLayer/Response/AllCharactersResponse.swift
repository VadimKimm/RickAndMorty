//
//  AllCharactersResponse.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import Foundation

struct AllCharactersResponse: Codable {
    var info: Info
    var results: [Character]

    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
}
