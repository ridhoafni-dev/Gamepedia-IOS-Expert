//
//  GetFavoriteLocaleDataSource.swift
//  Favorite
//
//  Created by User on 28/02/26.
//

import Core
import Combine
import Foundation
import Games
import RealmSwift

public struct GetFavoriteLocaleDataSource: LocaleDataSource {
    public typealias Request = Any
    public typealias Response = GameModuleEntity
    
    private let _realm: Realm
    
    public init(realm: Realm) {
        _realm = realm
    }
    
    public func list(request: Any?) -> AnyPublisher<[GameModuleEntity], Error> {
        return Future<[GameModuleEntity], Error> { completion in
            let games: Results<GameModuleEntity> = {
                _realm.objects(GameModuleEntity.self)
                    .filter("isFavorite == true")
            }()
            
            completion(.success(games.toArray(ofType: GameModuleEntity.self)))
        }.eraseToAnyPublisher()
    }
    
    public func update(id: Int, isFavorite: Bool) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            do {
                guard let currentData = _realm.objects(GameModuleEntity.self).where({
                    $0.id == id
                }).first else {
                    print("DEBUG Favorite Update - data not found for id: \(id)")
                    completion(.failure(DatabaseError.requestFailed))
                    return
                }
                
                print("DEBUG Favorite Update - BEFORE write")
                print("DEBUG id: \(currentData.id), name: \(currentData.name), isFavorite: \(currentData.isFavorite)")

                
                try _realm.write {
                    currentData.setValue(isFavorite, forKey: "isFavorite")
                }
                
                print("DEBUG Favorite Update - AFTER write")
                print("DEBUG id: \(currentData.id), name: \(currentData.name), isFavorite: \(currentData.isFavorite)")
                
                completion(.success(true))
            } catch {
                print("DEBUG Favorite Update - ERROR: \(error.localizedDescription)")
                completion(.failure(DatabaseError.requestFailed))
            }
        }.eraseToAnyPublisher()
    }
    
    public func add(entities: [GameModuleEntity]) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func get(id: String) -> AnyPublisher<GameModuleEntity, Error> {
        fatalError()
    }
    
    public func update(id: Int, entity: GameModuleEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
    
    public func add(entities: GameModuleEntity) -> AnyPublisher<Bool, Error> {
        fatalError()
    }
}
