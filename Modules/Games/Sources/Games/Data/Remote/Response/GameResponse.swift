//
//  GamesResponse.swift
//  Gamepedia
//
//  Created by User on 29/12/25.
//


import Foundation
nonisolated
struct GamesResponse: Decodable, Sendable {
    let games: GameResponse
}

nonisolated
struct GameResponse: Decodable, Sendable {
    let count: Int?
    let next, previous: String?
    let results: [GameResult]?
}

nonisolated
public struct GameResult: Decodable, Sendable {
    public let id: Int?
    public let name, released: String?
    public let backgroundImage: String?
    public let rating, ratingTop: Double?
    public let suggestionsCount: Int?
    public let updated: String?
    public let reviewsCount: Int?
    public let communityRating: Int?
    public let platforms: [Platforms]?
    public let genres: [Genre]?
    public let parentPlatforms: [ParentPlatform]?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case released
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case suggestionsCount = "suggestions_count"
        case updated
        case reviewsCount = "reviews_count"
        case communityRating = "community_rating"
        case platforms
        case genres
        case parentPlatforms = "parent_platforms"
    }
}

public struct Platforms: Decodable, Sendable {
    public let platform: Platform?
    public let releasedAt: String?

    private enum CodingKeys: String, CodingKey {
        case platform
        case releasedAt = "released_at"
    }
}

// The nested "platform" object used in lists
public struct Platform: Decodable, Sendable {
    public let id: Int?
    public let name, slug: String?
}

public struct Genre: Decodable, Sendable {
    public let id: Int?
    public let name, slug: String?
    public let gamesCount: Int?
    public let imageBackground: String?
    public let language: String?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
        case language
    }
}

public struct ParentPlatform: Decodable, Sendable {
    public let platform: ParentPlatformPlatform?
}

public struct ParentPlatformPlatform: Decodable, Sendable {
    public let id: Int?
    public let name, slug: String?
}
