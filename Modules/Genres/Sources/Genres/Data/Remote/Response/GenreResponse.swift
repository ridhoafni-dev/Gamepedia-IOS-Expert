//
//  GenreResponse.swift
//  Genres
//
//  Created by User on 22/02/26.
//


import Foundation
nonisolated
struct GenreResponse: Decodable {
    let count: Int?
    let next, previous: String?
    let results: [GenreResult]?
}

struct GameInGenre: Decodable {
    let id: Int?
    let name, slug: String?
    let added: Int?
}

nonisolated
struct GenreResult: Decodable {
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?
    let games: [GameInGenre]?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case games
    }
}
