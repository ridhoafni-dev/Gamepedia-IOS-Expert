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
    @Persisted public dynamic var name: String = ""
    @Persisted public dynamic var slug: String = ""
    @Persisted public dynamic var gameCount: Int = 0
    @Persisted public dynamic var imageBackground: String = ""
    @Persisted public var games: List<GameInDeveloperModuleEntity> = List<GameInDeveloperModuleEntity>()
}

public class GameInDeveloperModuleEntity: Object {
  @Persisted(primaryKey: true) public var id = ""
  @Persisted public dynamic var name: String = ""
  @Persisted public dynamic var slug: String = ""
  @Persisted public dynamic var added: Int = 0
  @Persisted(originProperty: "games") var assignee: LinkingObjects<DeveloperModuleEntity>
}
