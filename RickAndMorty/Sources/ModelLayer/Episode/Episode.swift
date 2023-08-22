//
//  Episode.swift
//  RickAndMorty
//
//  Created by Vadim Kim on 20.08.2023.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case id, name, episode, characters, url, created
    }
}
