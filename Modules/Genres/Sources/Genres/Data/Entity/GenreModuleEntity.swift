//
//  GenreModuleEntity.swift
//  Genres
//
//  Created by User on 22/02/26.
//

import Foundation
import RealmSwift

class GenreModuleEntity: Object {
  @Persisted(primaryKey: true) var id = 0
  @Persisted var name: String = ""
  @Persisted var slug: String = ""
  @Persisted var gameCount: Int = 0
  @Persisted var imageBackground: String = ""
  @Persisted var games: List<GameInGenreEntity>
  @Persisted dynamic var desc: String = "Unknown Description"
}

class GameInGenreEntity: Object {
  @Persisted(primaryKey: true) var id = ""
  @Persisted dynamic var name: String = ""
  @Persisted dynamic var slug: String = ""
  @Persisted dynamic var added: Int = 0
}
