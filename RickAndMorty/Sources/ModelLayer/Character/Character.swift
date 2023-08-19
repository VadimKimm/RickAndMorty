//
//  Character.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 19.08.2023.
//

import Foundation

struct Character: Codable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let type: String
    let gender: CharacterGender
    let origin: CharacterOrigin
    let location: CharacterLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
