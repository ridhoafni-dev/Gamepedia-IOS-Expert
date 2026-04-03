//
//  FavoriteTransformer.swift
//  Favorite
//
//  Created by User on 28/02/26.
//


import Core
import Games

public struct FavoriteTransformer: Mapper {
  public typealias Response = Bool
  public typealias Entity = [GameModuleEntity]
  public typealias Domain = [DetailGameDomainModel]
  
  public init() {}
  
  public func transformResponseToDomain(response: Bool) -> [DetailGameDomainModel] {
    return []
  }
  
  public func transformResponseToEntity(response: Bool) -> [GameModuleEntity] {
    return []
  }
  
  public func transformEntityToDomain(entity: [GameModuleEntity]) -> [DetailGameDomainModel] {
      return DetailGameTransformer.mapDetailGameEntitiesToDomains(input: entity)
  }
}

