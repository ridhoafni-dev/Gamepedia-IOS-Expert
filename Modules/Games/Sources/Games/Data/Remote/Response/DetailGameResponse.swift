//
//  DetailGameResponse.swift
//  Gamepedia
//
//  Created by User on 29/12/25.
//

import Foundation

nonisolated
    struct DetailGameResponse: Decodable, Sendable
{
    let id: Int?
    let slug, name, originalName, description: String?
    let released: String?
    let updated: String?
    let backgroundImage: String?
    let backgroundImageAdditional: String?
    let website: String?
    let rating: Double?
    let added: Int?
    let playtime: Int?
    let achievementsCount: Int?
    let ratingsCount, suggestionsCount: Int?
    let reviewsCount: Int?
    let parentPlatforms: [PlatformInDetail]?
    let platforms: [DetailPlatform]?
    let stores: [StoreDetails]?
    let developers: [Developer]?
    let genres: [GenreInDetails]?
    let tags: [Tag]?
    let publishers: [Publisher]?
    let descriptionRaw: String?

    private enum CodingKeys: String, CodingKey {
        case id, slug, name, description, released, updated
        case originalName = "name_original"
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case website, rating, added, playtime
        case achievementsCount = "achievements_count"
        case ratingsCount = "ratings_count"
        case suggestionsCount = "suggestions_count"
        case reviewsCount = "reviews_count"
        case parentPlatforms = "parent_platforms"
        case platforms, stores, developers, genres, tags, publishers
        case descriptionRaw = "description_raw"
    }
}

struct PlatformInDetail: Decodable {
    let platform: PlatformDetail
}

struct PlatformDetail: Decodable {
    let id: Int?
    let name, slug: String?
}

struct DetailPlatform: Decodable {
    let platform: PlatformDetails?
    let releasedAt: String?
    let requirements: PlatformRequirement?

    private enum CodingKeys: String, CodingKey {
        case platform, requirements
        case releasedAt = "released_at"
    }
}

struct PlatformDetails: Decodable {
    let id: Int?
    let name, slug: String?
    let image: String?
    let yearEnd, yearStart: Int?
    let gamesCount: Int?
    let imageBackground: String?

    private enum CodingKeys: String, CodingKey {
        case id, name, slug, image
        case yearEnd = "year_end"
        case yearStart = "year_start"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

struct PlatformRequirement: Decodable {
    let minimum: String?
}

struct StoreDetails: Decodable, Sendable {
    let id: Int?
    let url: String?
    let store: Store?
}

struct Store: Decodable, Sendable {
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let domain: String?
    let imageBackground: String?

    private enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case domain
        case imageBackground = "image_background"
    }
}

struct Developer: Decodable {
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?

    private enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

struct Publisher: Decodable {
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?

    private enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

struct GenreInDetails: Decodable, Sendable {
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?

    private enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

struct Tag: Decodable {
    let id: Int?
    let name, slug: String?
    let gamesCount: Int?
    let imageBackground: String?

    private enum CodingKeys: String, CodingKey {
        case id, name, slug
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}
