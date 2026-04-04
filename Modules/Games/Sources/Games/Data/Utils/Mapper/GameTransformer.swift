//
//  GameMapper.swift
//  Game
//
//  Created by User on 02/02/26.
//

final class GameTransformer {
    static func mapGameResponsesToDomains(
        input gameResponses: [GameResult]
    ) -> [GameDomainModel] {
        gameResponses.map { result in
            GameDomainModel(
                id: result.id ?? 0,
                name: result.name ?? "Unknown Name",
                released: result.released ?? "Unknown Release",
                backgroundImage: result.backgroundImage ?? "",
                rating: result.rating ?? 0.0,
                ratingTop: result.ratingTop ?? 0.0,
                suggestionsCount: result.suggestionsCount ?? 0,
                updated: result.updated ?? "Unknown date",
                reviewsCount: result.reviewsCount ?? 0,
                communityRating: result.communityRating ?? 0,
                platforms: result.platforms as? [PlatformDomainModel],
                genres: result.genres as? [GenreInGameDomainModel],
                parentPlatforms: result.parentPlatforms as? [ParentPlatformPlatformDomainModel]
            )
        }
    }
}
