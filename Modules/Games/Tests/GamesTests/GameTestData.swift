//
//  GameTestData.swift
//  GamesTests
//

import Foundation
@testable import Games

// MARK: - Factory helpers for test data

struct GameResultFactory {
    static func make(
        id: Int = 1,
        name: String = "Test Game",
        released: String = "2024-01-01",
        backgroundImage: String = "https://example.com/image.jpg",
        rating: Double = 4.5,
        ratingTop: Double = 5.0,
        suggestionsCount: Int = 100,
        updated: String = "2024-06-01",
        reviewsCount: Int = 50,
        communityRating: Int = 3
    ) -> GameResult {
        return GameResult(
            id: id,
            name: name,
            released: released,
            backgroundImage: backgroundImage,
            rating: rating,
            ratingTop: ratingTop,
            suggestionsCount: suggestionsCount,
            updated: updated,
            reviewsCount: reviewsCount,
            communityRating: communityRating,
            platforms: nil,
            genres: nil,
            parentPlatforms: nil
        )
    }

    static func makeNilFields() -> GameResult {
        return GameResult(
            id: nil,
            name: nil,
            released: nil,
            backgroundImage: nil,
            rating: nil,
            ratingTop: nil,
            suggestionsCount: nil,
            updated: nil,
            reviewsCount: nil,
            communityRating: nil,
            platforms: nil,
            genres: nil,
            parentPlatforms: nil
        )
    }
}

struct GameModuleEntityFactory {
    static func make(
        id: Int = 1,
        name: String = "Entity Game",
        slug: String = "entity-game",
        released: String = "2024-01-01",
        rating: Double = 4.2,
        isFavorite: Bool = false
    ) -> GameModuleEntity {
        let entity = GameModuleEntity()
        entity.id = id
        entity.name = name
        entity.slug = slug
        entity.originalName = name
        entity.desc = "A test description"
        entity.released = released
        entity.updated = "2024-06-01"
        entity.backgroundImage = "https://example.com/bg.jpg"
        entity.backgroundImageAdditional = ""
        entity.website = "https://example.com"
        entity.rating = rating
        entity.added = 200
        entity.playtime = 10
        entity.achievementsCount = 30
        entity.ratingsCount = 80
        entity.suggestionsCount = 15
        entity.reviewsCount = 40
        entity.descriptionRaw = "Raw description"
        entity.isFavorite = isFavorite
        return entity
    }
}

