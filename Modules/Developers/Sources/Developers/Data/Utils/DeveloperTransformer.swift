//
//  DeveloperTransformer.swift
//  Developer
//
//  Created by User on 08/02/26.
//


import Core
import Foundation
import RealmSwift
public final class DeveloperTransformer: Mapper {
    public typealias Response = [DeveloperResult]
    public typealias Entity = [DeveloperModuleEntity]
    public typealias Domain = [DeveloperDomainModel]

    public init() {}

    public func transformResponseToEntity(response: [DeveloperResult]) -> [DeveloperModuleEntity] {
        return DeveloperTransformer.mapDevelopersResponsesToEntities(input: response)
    }

    public func transformEntityToDomain(entity: [DeveloperModuleEntity]) -> [DeveloperDomainModel] {
        return DeveloperTransformer.mapDeveloperEntitiesToDomains(input: entity)
    }

    public func transformResponseToDomain(response: [DeveloperResult]) -> [DeveloperDomainModel] {
        return DeveloperTransformer.mapDeveloperResponsesToDomains(input: response)
    }

  static func mapDevelopersResponsesToEntities(
    input developersResponses: [DeveloperResult]
  ) -> [DeveloperModuleEntity] {
    return developersResponses.map { result in
      let newDeveloper = DeveloperModuleEntity()

      newDeveloper.id = String(result.id ?? 0)
      newDeveloper.name = result.name ?? "Unknown Name"
      newDeveloper.slug = result.slug ?? "Unknown Slug"
      newDeveloper.gameCount = result.gamesCount ?? 0
      newDeveloper.imageBackground = result.imageBackground ?? ""

      let temp = List<GameInDeveloperModuleEntity>()
      for game in result.games! {
        let gameTemp = GameInDeveloperModuleEntity()
        gameTemp.id = String(game.id ?? 0)
        gameTemp.added = game.added ?? 0
        gameTemp.slug = game.slug ?? "Unknown Slug"
        gameTemp.name = game.name ?? "Unknown Name"

        temp.append(gameTemp)
      }
      newDeveloper.games = temp
      return newDeveloper
    }
  }

  static func mapDeveloperEntitiesToDomains(
    input developerEntities: [DeveloperModuleEntity]
  ) -> [DeveloperDomainModel] {
    return developerEntities.map { result in
      return DeveloperDomainModel(
        id: Int(result.id),
        name: result.name,
        slug: result.slug,
        gamesCount: result.gameCount,
        imageBackground: result.imageBackground,
        games: result.games.map { game in
          return GameInDeveloperDomainModel(
            id: Int(game.id),
            name: game.name,
            slug: game.slug,
            added: game.added
          )
        }
      )
    }
  }

  static func mapDeveloperResponsesToDomains(
    input developerResponses: [DeveloperResult]
  ) -> [DeveloperDomainModel] {

    return developerResponses.map { result in
      return DeveloperDomainModel(
        id: result.id ?? 0,
        name: result.name ?? "Unknown Name",
        slug: result.slug ?? "Unknown Slug",
        gamesCount: result.gamesCount ?? 0,
        imageBackground: result.imageBackground ?? "",
        games: (result.games!) as! [GameInDeveloperDomainModel]
      )
    }
  }
}
