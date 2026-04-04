//
//  DeveloperModuleEntity.swift
//  Developer
//
//  Created by User on 08/02/26.
//


import Foundation
import RealmSwift
public class DeveloperModuleEntity: Object {
  @Persisted(primaryKey: true) public var id = ""
  @Persisted dynamic public var name: String = ""
  @Persisted dynamic public var slug: String = ""
  @Persisted dynamic public var gameCount: Int = 0
  @Persisted dynamic public var imageBackground: String = ""
  @Persisted public var games: List<GameInDeveloperModuleEntity> = List<GameInDeveloperModuleEntity>()
}

public class GameInDeveloperModuleEntity: Object {
  @Persisted(primaryKey: true) public var id = ""
  @Persisted dynamic public var name: String = ""
  @Persisted dynamic public var slug: String = ""
  @Persisted dynamic public var added: Int = 0
  @Persisted(originProperty: "games") var assignee: LinkingObjects<DeveloperModuleEntity>
}
