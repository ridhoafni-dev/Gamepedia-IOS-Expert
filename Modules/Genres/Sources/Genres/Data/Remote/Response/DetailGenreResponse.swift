//
//  DetailGenreResponse.swift
//  Genres
//
//  Created by User on 22/02/26.
//


import Foundation
nonisolated
struct DetailGenreResponse: Decodable {
    var id: Int?
    var name, slug: String?
    var gamesCount: Int?
    var imageBackground: String?
    var description: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case description
    }
}
