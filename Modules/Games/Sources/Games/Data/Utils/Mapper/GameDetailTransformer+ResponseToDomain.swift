//
//  GameDetailTransformer+ResponseToDomain.swift
//  Game
//
//  Created by User on 07/02/26.
//

import Foundation

extension DetailGameTransformer {
  static func mapDetailGameResponsesToDomains(
    input detailGameResponses: DetailGameResponse
  ) -> DetailGameDomainModel {
    DetailGameDomainModel(
      id: detailGameResponses.id,
      isFavorite: false,
      slug: detailGameResponses.slug ?? "Unknown slug",
      name: detailGameResponses.name ?? "Unknown Name",
      nameOriginal: detailGameResponses.originalName ?? "Unknown Original Name",
      description: detailGameResponses.description ?? "No description",
      released: detailGameResponses.released ?? "Unknown released",
      updated: detailGameResponses.updated ?? "Unknown last updates",
      backgroundImage: detailGameResponses.backgroundImage ?? "",
      backgroundImageAdditional: detailGameResponses.backgroundImageAdditional ?? "",
      website: detailGameResponses.website ?? "",
      rating: detailGameResponses.rating ?? 0.0,
      added: detailGameResponses.added ?? 0,
      playtime: detailGameResponses.playtime ?? 0,
      achievementsCount: detailGameResponses.achievementsCount ?? 0,
      ratingsCount: detailGameResponses.ratingsCount ?? 0,
      suggestionsCount: detailGameResponses.suggestionsCount ?? 0,
      reviewsCount: detailGameResponses.reviewsCount ?? 0,
      parentPlatforms: mapParentPlatformsToDomains(detailGameResponses.parentPlatforms),
      platforms: mapPlatformsToDomains(detailGameResponses.platforms),
      stores: mapStoresToDomains(detailGameResponses.stores),
      developers: mapDevelopersToDomains(detailGameResponses.developers),
      genres: mapGenresToDomains(detailGameResponses.genres),
      tags: mapTagsToDomains(detailGameResponses.tags),
      publishers: mapPublishersToDomains(detailGameResponses.publishers),
      descriptionRaw: detailGameResponses.descriptionRaw ?? ""
    )
  }

  // MARK: - Helper Methods

  private static func mapParentPlatformsToDomains(
    _ parentPlatforms: [PlatformInDetail]?
  ) -> [PlatformDomainModel] {
    (parentPlatforms ?? []).map {
      PlatformDomainModel(
        id: UUID(),
        name: $0.platform.name ?? "Unknown Name",
        slug: $0.platform.slug ?? "Unknown Slug"
      )
    }
  }

  private static func mapPlatformsToDomains(
    _ platforms: [DetailPlatform]?
  ) -> [DetailPlatformDomainModel] {
    (platforms ?? []).map { platform in
      let detail = PlatformDetailsDomainModel(
        id: UUID(),
        name: platform.platform?.name ?? "Unknown Name",
        slug: platform.platform?.slug ?? "Unknown Slug",
        image: platform.platform?.image ?? "",
        yearEnd: platform.platform?.yearEnd ?? 0,
        yearStart: platform.platform?.yearStart ?? 0,
        gamesCount: platform.platform?.gamesCount ?? 0,
        imageBackground: platform.platform?.imageBackground ?? ""
      )
      let requirement = PlatformRequirementDomainModel(
        id: UUID(),
        minimum: platform.requirements?.minimum ?? ""
      )
      return DetailPlatformDomainModel(
        id: UUID(),
        platform: detail,
        releasedAt: platform.releasedAt ?? "",
        requirements: requirement
      )
    }
  }

  private static func mapStoresToDomains(
    _ stores: [StoreDetails]?
  ) -> [StoreDetailsDomainModel] {
    (stores ?? []).map { store in
      StoreDetailsDomainModel(
        id: UUID(),
        url: store.url,
        store: StoreDomainModel(
          id: UUID(),
          name: store.store?.name,
          slug: store.store?.slug,
          gamesCount: store.store?.gamesCount,
          domain: store.store?.domain,
          imageBackground: store.store?.imageBackground
        )
      )
    }
  }

  private static func mapDevelopersToDomains(
    _ developers: [Developer]?
  ) -> [DeveloperInDetailGameDomainModel] {
    (developers ?? []).map {
      DeveloperInDetailGameDomainModel(
        id: UUID(),
        name: $0.name,
        slug: $0.slug,
        gamesCount: $0.gamesCount,
        imageBackground: $0.imageBackground
      )
    }
  }

  private static func mapGenresToDomains(
    _ genres: [GenreInDetails]?
  ) -> [GenreInDetailsDomainModel] {
    (genres ?? []).map {
      GenreInDetailsDomainModel(
        id: UUID(),
        name: $0.name,
        slug: $0.slug,
        gamesCount: $0.gamesCount,
        imageBackground: $0.imageBackground
      )
    }
  }

  private static func mapTagsToDomains(
    _ tags: [Tag]?
  ) -> [TagDomainModel] {
    (tags ?? []).map {
      TagDomainModel(
        id: UUID(),
        name: $0.name,
        slug: $0.slug,
        gamesCount: $0.gamesCount,
        imageBackground: $0.imageBackground
      )
    }
  }

  private static func mapPublishersToDomains(
    _ publishers: [Publisher]?
  ) -> [PublisherDomainModel] {
    (publishers ?? []).map {
      PublisherDomainModel(
        id: UUID(),
        name: $0.name,
        slug: $0.slug,
        gamesCount: $0.gamesCount,
        imageBackground: $0.imageBackground
      )
    }
  }
}
