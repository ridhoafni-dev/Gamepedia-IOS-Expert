//
//  DetailGameDomainModel.swift
//  Game
//
//  Created by User on 02/02/26.
//

import Foundation

public struct DetailGameDomainModel: Equatable, Identifiable {
  public let id: Int?
  public let isFavorite: Bool?
  public let slug, name, nameOriginal, description: String?
  public let released: String?
  public let updated: String?
  public let backgroundImage: String?
  public let backgroundImageAdditional: String?
  public let website: String?
  public let rating: Double?
  public let added: Int?
  public let playtime: Int?
  public let achievementsCount: Int?
  public let ratingsCount, suggestionsCount: Int?
  public let reviewsCount: Int?
  public let parentPlatforms: [PlatformDomainModel]?
  public let platforms: [DetailPlatformDomainModel]?
  public let stores: [StoreDetailsDomainModel]?
  public let developers: [DeveloperInDetailGameDomainModel]?
  public let genres: [GenreInDetailsDomainModel]?
  public let tags: [TagDomainModel]?
  public let publishers: [PublisherDomainModel]?
  public let descriptionRaw: String?
  
  public init(id: Int?, isFavorite: Bool?, slug: String?, name: String?, nameOriginal: String?, description: String?, released: String?, updated: String?, backgroundImage: String?, backgroundImageAdditional: String?, website: String?, rating: Double?, added: Int?, playtime: Int?, achievementsCount: Int?, ratingsCount: Int?, suggestionsCount: Int?, reviewsCount: Int?, parentPlatforms: [PlatformDomainModel]?, platforms: [DetailPlatformDomainModel]?, stores: [StoreDetailsDomainModel]?, developers: [DeveloperInDetailGameDomainModel]?, genres: [GenreInDetailsDomainModel]?, tags: [TagDomainModel]?, publishers: [PublisherDomainModel]?, descriptionRaw: String?) {
      self.id = id
      self.isFavorite = isFavorite
      self.slug = slug
      self.name = name
      self.nameOriginal = nameOriginal
      self.description = description
      self.released = released
      self.updated = updated
      self.backgroundImage = backgroundImage
      self.backgroundImageAdditional = backgroundImageAdditional
      self.website = website
      self.rating = rating
      self.added = added
      self.playtime = playtime
      self.achievementsCount = achievementsCount
      self.ratingsCount = ratingsCount
      self.suggestionsCount = suggestionsCount
      self.reviewsCount = reviewsCount
      self.parentPlatforms = parentPlatforms
      self.platforms = platforms
      self.stores = stores
      self.developers = developers
      self.genres = genres
      self.tags = tags
      self.publishers = publishers
      self.descriptionRaw = descriptionRaw
  }
}

public struct DetailPlatformDomainModel: Equatable, Identifiable {
    public let id: UUID
    public let platform: PlatformDetailsDomainModel?
    public let releasedAt: String?
    public let requirements: PlatformRequirementDomainModel?
    
    public init(id: UUID, platform: PlatformDetailsDomainModel?, releasedAt: String?, requirements: PlatformRequirementDomainModel?) {
        self.id = id
        self.platform = platform
        self.releasedAt = releasedAt
        self.requirements = requirements
    }
}

public struct PlatformDetailsDomainModel: Equatable, Identifiable{
    public var id: UUID
    public let name, slug: String?
    public let image: String?
    public let yearEnd, yearStart: Int?
    public let gamesCount: Int?
    public let imageBackground: String?
    
    public init(id: UUID, name: String?, slug: String?, image: String?, yearEnd: Int?, yearStart: Int?, gamesCount: Int?, imageBackground: String?) {
        self.id = id
        self.name = name
        self.slug = slug
        self.image = image
        self.yearEnd = yearEnd
        self.yearStart = yearStart
        self.gamesCount = gamesCount
        self.imageBackground = imageBackground
    }
}

public struct PlatformRequirementDomainModel: Equatable, Identifiable{
  public let id: UUID
  public let minimum: String?
  
  public init(id: UUID, minimum: String?) {
      self.id = id
      self.minimum = minimum
  }
}

public struct StoreDetailsDomainModel: Equatable, Identifiable{
    public let id: UUID
    public let url: String?
    public let store: StoreDomainModel?
    
    public init(id: UUID, url: String?, store: StoreDomainModel?) {
        self.id = id
        self.url = url
        self.store = store
    }
}

public struct StoreDomainModel: Equatable, Identifiable{
    public let id: UUID
    public let name, slug: String?
    public let gamesCount: Int?
    public let domain: String?
    public let imageBackground: String?
    
    public init(id: UUID, name: String?, slug: String?, gamesCount: Int?, domain: String?, imageBackground: String?) {
        self.id = id
        self.name = name
        self.slug = slug
        self.gamesCount = gamesCount
        self.domain = domain
        self.imageBackground = imageBackground
    }
}

public struct DeveloperInDetailGameDomainModel: Equatable, Identifiable{
    public let id: UUID
    public let name, slug: String?
    public let gamesCount: Int?
    public let imageBackground: String?
    
    public init(id: UUID, name: String?, slug: String?, gamesCount: Int?, imageBackground: String?) {
        self.id = id
        self.name = name
        self.slug = slug
        self.gamesCount = gamesCount
        self.imageBackground = imageBackground
    }
}

public struct PublisherDomainModel: Equatable, Identifiable{
    public let id: UUID
    public let name, slug: String?
    public let gamesCount: Int?
    public let imageBackground: String?
    
    public init(id: UUID, name: String?, slug: String?, gamesCount: Int?, imageBackground: String?) {
        self.id = id
        self.name = name
        self.slug = slug
        self.gamesCount = gamesCount
        self.imageBackground = imageBackground
    }
}

public struct GenreInDetailsDomainModel: Equatable, Identifiable{
    public let id: UUID
    public let name, slug: String?
    public let gamesCount: Int?
    public let imageBackground: String?
    
    public init(id: UUID, name: String?, slug: String?, gamesCount: Int?, imageBackground: String?) {
        self.id = id
        self.name = name
        self.slug = slug
        self.gamesCount = gamesCount
        self.imageBackground = imageBackground
    }
}

public struct TagDomainModel: Equatable, Identifiable{
    public let id: UUID
    public let name, slug: String?
    public let gamesCount: Int?
    public let imageBackground: String?
    
    public init(id: UUID, name: String?, slug: String?, gamesCount: Int?, imageBackground: String?) {
        self.id = id
        self.name = name
        self.slug = slug
        self.gamesCount = gamesCount
        self.imageBackground = imageBackground
    }
}
