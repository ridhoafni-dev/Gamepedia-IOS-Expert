//
//  SearchModuleEntity.swift
//  SearchGame
//
//  Created by User on 26/02/26.
//

import RealmSwift
import Foundation

public class SearchModuleEntity: Object {
    @Persisted(primaryKey: true) public var id: Int = 0
    @Persisted public var slug = ""
    @Persisted public var name = ""
    @Persisted public var playtime = 0
    @Persisted public var released = ""
    @Persisted public var rating = 0.0
    @Persisted public var score = ""
    @Persisted public var backgroundImage = ""
    
}
