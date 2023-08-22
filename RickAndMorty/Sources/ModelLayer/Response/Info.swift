//
//  Info.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 22.08.2023.
//

import Foundation

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
