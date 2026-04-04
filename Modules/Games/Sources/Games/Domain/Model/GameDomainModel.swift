//
//  GameDomainModel.swift
//  Game
//
//  Created by User on 02/02/26.
//

import Foundation

public struct GameDomainModel: Equatable {
    public let id: Int?
    public let name, released: String?
    public let backgroundImage: String?
    public let rating, ratingTop: Double?
    public let suggestionsCount: Int?
    public let updated: String?
    public let reviewsCount: Int?
    public let communityRating: Int?
    public let platforms: [PlatformDomainModel]?
    public let genres: [GenreInGameDomainModel]?
    public let parentPlatforms: [ParentPlatformPlatformDomainModel]?

    public init(
        id: Int?,
        name: String?,
        released: String?,
        backgroundImage: String?,
        rating: Double?,
        ratingTop: Double?,
        suggestionsCount: Int?,
        updated: String?,
        reviewsCount: Int?,
        communityRating: Int?,
        platforms: [PlatformDomainModel]?,
        genres: [GenreInGameDomainModel]?,
        parentPlatforms: [ParentPlatformPlatformDomainModel]?
    ) {
        self.id = id
        self.name = name
        self.released = released
        self.backgroundImage = backgroundImage
        self.rating = rating
        self.ratingTop = ratingTop
        self.suggestionsCount = suggestionsCount
        self.updated = updated
        self.reviewsCount = reviewsCount
        self.communityRating = communityRating
        self.platforms = platforms
        self.genres = genres
        self.parentPlatforms = parentPlatforms
    }
}

public struct PlatformsDomainModel: Equatable {
    public let platform: PlatformDomainModel?
    public let releasedAt: String?

    public init(platform: PlatformDomainModel?, releasedAt: String?) {
        self.platform = platform
        self.releasedAt = releasedAt
    }
}

public struct PlatformDomainModel: Equatable, Identifiable {
    public let id: UUID
    public let name, slug: String?

    public init(id: UUID, name: String?, slug: String?) {
        self.id = id
        self.name = name
        self.slug = slug
    }
}

public struct ParentPlatformPlatformDomainModel: Equatable, Identifiable {
    public let id: Int?
    public let name, slug: String?

    public init(id: Int?, name: String?, slug: String?) {
        self.id = id
        self.name = name
        self.slug = slug
    }
}

public struct GenreInGameDomainModel: Equatable, Identifiable {
    public let id: Int?
    public let name, slug: String?
    public let gamesCount: Int?
    public let imageBackground: String?
    public let language: String?

    public init(
        id: Int?,
        name: String?,
        slug: String?,
        gamesCount: Int?,
        imageBackground: String?,
        language: String?
    ) {
        self.id = id
        self.name = name
        self.slug = slug
        self.gamesCount = gamesCount
        self.imageBackground = imageBackground
        self.language = language
    }
}
