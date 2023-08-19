//
//  CharacterStatus.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import Foundation

enum CharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown
}
