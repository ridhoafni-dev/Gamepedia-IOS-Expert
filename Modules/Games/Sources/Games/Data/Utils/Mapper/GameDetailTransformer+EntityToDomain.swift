//
//  GameDetailTransformer+EntityToDomain.swift
//  Game
//
//  Created by User on 07/02/26.
//

import Foundation
import RealmSwift

public extension DetailGameTransformer {
  static func mapDetailGameEntitiesToDomains(
    input detailGameEntities: [GameModuleEntity]
  ) -> [DetailGameDomainModel] {
    detailGameEntities.map { mapGameEntityToDomainModel($0) }
  }

  // MARK: - Helper Methods

  private static func mapGameEntityToDomainModel(
    _ result: GameModuleEntity
  ) -> DetailGameDomainModel {
    DetailGameDomainModel(
      id: Int(result.id),
      isFavorite: result.isFavorite,
      slug: result.slug,
      name: result.name,
      nameOriginal: result.originalName,
      description: result.desc,
      released: result.released,
      updated: result.updated,
      backgroundImage: result.backgroundImage,
      backgroundImageAdditional: result.backgroundImageAdditional,
      website: result.website,
      rating: result.rating,
      added: result.added,
      playtime: result.playtime,
      achievementsCount: result.achievementsCount,
      ratingsCount: result.ratingsCount,
      suggestionsCount: result.suggestionsCount,
      reviewsCount: result.reviewsCount,
      parentPlatforms: mapEntityParentPlatforms(result.parentPlatforms),
      platforms: mapEntityPlatforms(result.platforms),
      stores: mapEntityStores(result.stores),
      developers: mapEntityDevelopers(result.developers),
      genres: mapEntityGenres(result.genres),
      tags: mapEntityTags(result.tags),
      publishers: mapEntityPublishers(result.publishers),
      descriptionRaw: result.descriptionRaw
    )
  }

  private static func mapEntityParentPlatforms(
    _ parentPlatforms: List<PlatformModuleEntity>
  ) -> [PlatformDomainModel] {
    parentPlatforms.map { platform in
      PlatformDomainModel(
        id: platform.id,
        name: platform.name,
        slug: platform.slug
      )
    }
  }

  private static func mapEntityPlatforms(
    _ platforms: List<DetailPlatformModuleEntity>
  ) -> [DetailPlatformDomainModel] {
    platforms.map { data in
      DetailPlatformDomainModel(
        id: data.id,
        platform: PlatformDetailsDomainModel(
          id: data.platform!.id,
          name: data.platform?.name,
          slug: data.platform?.slug,
          image: data.platform?.image,
          yearEnd: data.platform?.yearEnd,
          yearStart: data.platform?.yearStart,
          gamesCount: data.platform?.gamesCount,
          imageBackground: data.platform?.imageBackground
        ),
        releasedAt: data.releasedAt,
        requirements: PlatformRequirementDomainModel(
          id: data.requirements!.id,
          minimum: data.requirements?.minimum
        )
      )
    }
  }

  private static func mapEntityStores(
    _ stores: List<StoreDetailsModuleEntity>
  ) -> [StoreDetailsDomainModel] {
    stores.map { store in
      StoreDetailsDomainModel(
        id: store.id,
        url: store.url,
        store: StoreDomainModel(
          id: store.store!.id,
          name: store.store?.name,
          slug: store.store?.slug,
          gamesCount: store.store?.gamesCount,
          domain: store.store?.domain,
          imageBackground: store.store?.imageBackground
        )
      )
    }
  }

  private static func mapEntityDevelopers(
    _ developers: List<DeveloperInDetailsModuleEntity>
  ) -> [DeveloperInDetailGameDomainModel] {
    developers.map { developer in
      DeveloperInDetailGameDomainModel(
        id: developer.id,
        name: developer.name,
        slug: developer.slug,
        gamesCount: developer.gamesCount,
        imageBackground: developer.imageBackground
      )
    }
  }

  private static func mapEntityGenres(
    _ genres: List<GenreInDetailsModuleEntity>
  ) -> [GenreInDetailsDomainModel] {
    genres.map { genre in
      GenreInDetailsDomainModel(
        id: genre.id,
        name: genre.name,
        slug: genre.slug,
        gamesCount: genre.gamesCount,
        imageBackground: genre.imageBackground
      )
    }
  }

  private static func mapEntityTags(
    _ tags: List<TagModuleEntity>
  ) -> [TagDomainModel] {
    tags.map { tag in
      TagDomainModel(
        id: tag.id,
        name: tag.name,
        slug: tag.slug,
        gamesCount: tag.gamesCount,
        imageBackground: tag.imageBackground
      )
    }
  }

  private static func mapEntityPublishers(
    _ publishers: List<PublisherModuleEntity>
  ) -> [PublisherDomainModel] {
    publishers.map { publisher in
      PublisherDomainModel(
        id: publisher.id,
        name: publisher.name,
        slug: publisher.slug,
        gamesCount: publisher.gamesCount,
        imageBackground: publisher.imageBackground
      )
    }
  }

  static func mapDetailGameEntityToDomain(
    input result: GameModuleEntity
  ) -> DetailGameDomainModel {
    mapGameEntityToDomainModel(result)
  }

  static func mapDetailGameEntitiesToDomain(
    input gameEntities: [GameModuleEntity]
  ) -> [DetailGameDomainModel] {
    gameEntities.map { mapGameEntityToDomainModel($0) }
  }
}
