//
//  GameDetailTransformer.swift
//  Game
//
//  Created by User on 07/02/26.
//

import Foundation
import RealmSwift

public class DetailGameTransformer {
    // MARK: - Main Mapping Function

    static func mapDetailGameResponsesToEntities(
        input detailResponse: DetailGameResponse
    ) -> GameModuleEntity {
        let result = detailResponse
        let newDetailGame = GameModuleEntity()

        // Map basic properties
        mapBasicProperties(from: result, to: newDetailGame)

        // Map related entities
        newDetailGame.parentPlatforms = mapParentPlatforms(from: result)
        newDetailGame.platforms = mapPlatforms(from: result)
        newDetailGame.stores = mapStores(from: result)
        newDetailGame.developers = mapDevelopers(from: result)
        newDetailGame.genres = mapGenres(from: result)
        newDetailGame.tags = mapTags(from: result)
        newDetailGame.publishers = mapPublishers(from: result)

        return newDetailGame
    }

    // MARK: - Helper Methods

    private static func mapBasicProperties(
        from source: DetailGameResponse,
        to destination: GameModuleEntity
    ) {
        destination.id = source.id ?? 0
        destination.isFavorite = false
        destination.name = source.name ?? "Unknown Name"
        destination.originalName =
            source.originalName ?? "Unknown Original Name"
        destination.slug = source.slug ?? "Unknown Slug"
        destination.desc = source.description ?? "No description"
        destination.released = source.released ?? "Unknown released"
        destination.updated = source.updated ?? "Unknown updated"
        destination.backgroundImage = source.backgroundImage ?? ""
        destination.backgroundImageAdditional =
            source.backgroundImageAdditional ?? ""
        destination.website = source.website ?? ""
        destination.rating = source.rating ?? 0.0
        destination.added = source.added ?? 0
        destination.playtime = source.playtime ?? 0
        destination.achievementsCount = source.achievementsCount ?? 0
        destination.ratingsCount = source.ratingsCount ?? 0
        destination.suggestionsCount = source.suggestionsCount ?? 0
        destination.reviewsCount = source.reviewsCount ?? 0
        destination.descriptionRaw = source.descriptionRaw ?? ""
    }

    private static func mapParentPlatforms(
        from source: DetailGameResponse
    ) -> List<PlatformModuleEntity> {
        let temp = List<PlatformModuleEntity>()
        for platform in source.parentPlatforms ?? [] {
            let platformTemp = PlatformModuleEntity()
            platformTemp.id = UUID()
            platformTemp.slug = platform.platform.slug ?? "Unknown Slug"
            platformTemp.name = platform.platform.name ?? "Unknown Name"
            temp.append(platformTemp)
        }
        return temp
    }

    private static func mapPlatforms(
        from source: DetailGameResponse
    ) -> List<DetailPlatformModuleEntity> {
        let temp = List<DetailPlatformModuleEntity>()
        for platform in source.platforms ?? [] {
            let platformTemp = DetailPlatformModuleEntity()
            let platformDetailTemp = PlatformDetailsModuleEntity()
            platformDetailTemp.id = UUID()
            platformDetailTemp.name = platform.platform?.name ?? "Unknown name"
            platformDetailTemp.slug = platform.platform?.slug ?? "Unknown slug"
            platformDetailTemp.gamesCount = platform.platform?.gamesCount ?? 0
            platformDetailTemp.image = platform.platform?.image ?? ""
            platformDetailTemp.imageBackground =
                platform.platform?.imageBackground ?? ""
            platformDetailTemp.yearEnd = platform.platform?.yearEnd ?? 0
            platformDetailTemp.yearStart = platform.platform?.yearStart ?? 0

            let platfromRequrementTemp = PlatformRequirementModuleEntity()
            platfromRequrementTemp.minimum =
                platform.requirements?.minimum ?? ""

            platformTemp.platform = platformDetailTemp
            platformTemp.releasedAt = platform.releasedAt ?? "Unknown release"
            platformTemp.requirements = platfromRequrementTemp

            temp.append(platformTemp)
        }
        return temp
    }

    private static func mapStores(
        from source: DetailGameResponse
    ) -> List<StoreDetailsModuleEntity> {
        let temp = List<StoreDetailsModuleEntity>()
        for store in source.stores ?? [] {
            let storeTemp = StoreDetailsModuleEntity()
            let storeEntity = StoreModuleEntity()
            storeEntity.id = UUID()
            storeEntity.name = store.store?.name ?? "Unknown name"
            storeEntity.slug = store.store?.slug ?? "Unknown slug"
            storeEntity.gamesCount = store.store?.gamesCount ?? 0
            storeEntity.domain = store.store?.domain ?? "Unknown domain"
            storeEntity.imageBackground = store.store?.imageBackground ?? ""

            storeTemp.id = UUID()
            storeTemp.url = store.url ?? ""
            storeTemp.store = storeEntity

            temp.append(storeTemp)
        }
        return temp
    }

    private static func mapDevelopers(
        from source: DetailGameResponse
    ) -> List<DeveloperInDetailsModuleEntity> {
        let temp = List<DeveloperInDetailsModuleEntity>()
        let devs = (source.developers ?? []).map {
            developer -> DeveloperInDetailsModuleEntity in
            let entity = DeveloperInDetailsModuleEntity()
            entity.id = UUID()
            entity.name = developer.name ?? "Unknown name"
            entity.slug = developer.slug ?? "Unknown slug"
            entity.gamesCount = developer.gamesCount ?? 0
            entity.imageBackground = developer.imageBackground ?? ""
            return entity
        }
        temp.append(objectsIn: devs)
        return temp
    }

    private static func mapGenres(
        from source: DetailGameResponse
    ) -> List<GenreInDetailsModuleEntity> {
        let temp = List<GenreInDetailsModuleEntity>()
        for genre in source.genres ?? [] {
            let genreInDetailsEntity = GenreInDetailsModuleEntity()
            genreInDetailsEntity.id = UUID()
            genreInDetailsEntity.name = genre.name ?? "Unknown name"
            genreInDetailsEntity.slug = genre.slug ?? "Unknown slug"
            genreInDetailsEntity.gamesCount = genre.gamesCount ?? 0
            genreInDetailsEntity.imageBackground = genre.imageBackground ?? ""
            temp.append(genreInDetailsEntity)
        }
        return temp
    }

    private static func mapTags(
        from source: DetailGameResponse
    ) -> List<TagModuleEntity> {
        let temp = List<TagModuleEntity>()
        for tag in source.tags ?? [] {
            let tagEntity = TagModuleEntity()
            tagEntity.id = UUID()
            tagEntity.name = tag.name ?? "Unknown name"
            tagEntity.slug = tag.slug ?? "Unknown slug"
            tagEntity.gamesCount = tag.gamesCount ?? 0
            tagEntity.imageBackground = tag.imageBackground ?? ""
            temp.append(tagEntity)
        }
        return temp
    }

    private static func mapPublishers(
        from source: DetailGameResponse
    ) -> List<PublisherModuleEntity> {
        let temp = List<PublisherModuleEntity>()
        for publisher in source.publishers ?? [] {
            let publisherEntity = PublisherModuleEntity()
            publisherEntity.id = UUID()
            publisherEntity.name = publisher.name ?? "Unknown name"
            publisherEntity.slug = publisher.slug ?? "Unknown slug"
            publisherEntity.gamesCount = publisher.gamesCount ?? 0
            publisherEntity.imageBackground = publisher.imageBackground ?? ""
            temp.append(publisherEntity)
        }
        return temp
    }

    static func mapDetailGameResponsesToEntitiesArray(
        input detailResponse: [DetailGameResponse]
    ) -> [GameModuleEntity] {
        return detailResponse.map { result in
            let newDetailGame = GameModuleEntity()
            mapBasicProperties(from: result, to: newDetailGame)
            newDetailGame.parentPlatforms = mapParentPlatforms(from: result)
            newDetailGame.platforms = mapPlatforms(from: result)
            newDetailGame.stores = mapStores(from: result)
            newDetailGame.developers = mapDevelopers(from: result)
            newDetailGame.genres = mapGenres(from: result)
            newDetailGame.tags = mapTags(from: result)
            newDetailGame.publishers = mapPublishers(from: result)
            return newDetailGame
        }
    }

    static func mapDetailGameResponseToEntities(
        input gameResults: [GameResult]
    ) -> [GameModuleEntity] {
        return gameResults.map { result in
            let newDetailGame = GameModuleEntity()

            newDetailGame.id = result.id ?? 0
            newDetailGame.isFavorite = false  // default for first store
            newDetailGame.name = result.name ?? "Unknown Name"
            newDetailGame.released = result.released ?? "Unknown released"
            newDetailGame.backgroundImage = result.backgroundImage ?? ""
            newDetailGame.rating = result.rating ?? 0.0
            newDetailGame.suggestionsCount = result.suggestionsCount ?? 0
            newDetailGame.reviewsCount = result.reviewsCount ?? 0
            newDetailGame.updated = result.updated ?? "Unknown updated"

            return newDetailGame
        }
    }
}
