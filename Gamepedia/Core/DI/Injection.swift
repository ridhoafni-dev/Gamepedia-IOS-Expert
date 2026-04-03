//
//  Injection.swift
//  Gamepedia
//
//  Created by User on 02/01/26.
//

import Foundation
import RealmSwift
import Games
import Core
import Favorite
import SearchGame
import Genres
import Developers

final class Injection: NSObject {
    
    let realm: Realm = {
        do {
            return try Realm()
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }()
    
    func provideGame() -> GameInteractor {
        let repository = GetGamesRepository(
            remote: GetGamesRemoteDataSource(),
            locale: GetGameLocaleDataSource(realm: realm)
        )
        return GameInteractor(repository: repository, isAdd: false)
    }
    
    func provideGameDetail(isAdd: Bool = false) -> GameInteractor {
        let repository = GetGamesRepository(
            remote: GetGamesRemoteDataSource(),
            locale: GetGameLocaleDataSource(realm: realm)
        )
        return GameInteractor(repository: repository, isAdd: isAdd)
    }
    
    func provideGenre() -> GenreInteractor {
        let repository = GetGenresRepository(locale: GetGenresLocaleDataSource(realm: realm), remote: GetGenresRemoteDataSource())
        return GenreInteractor(repository: repository)
    }
    
    func provideFavorite<U: UseCase>() -> U where U.Request == Any, U.Response == [Favorite.DetailGameDomainModel] {
        let locale = GetFavoriteLocaleDataSource(realm: realm)
        let mapper = FavoriteTransformer()
        let repository = GetFavoritiesRepository(
            localeDataSource: locale,
            mapper: mapper
        )
        return Interactor(repository: repository) as! U
    }
    
    func provideSearch<U: UseCase>() -> U where U.Request == Any, U.Response == [SearchDomainModel] {
          let remote = GetSearchRemoteDataSource(endpoint: Endpoints.Gets.games.url)
          let mapper = SearchTransformer()
          let repository = GetSearchRepository(
              remoteDataSource: remote,
              mapper: mapper
          )
          return Interactor(repository: repository) as! U
      }
    
    func provideDeveloper<U: UseCase>() -> U where U.Request == Any, U.Response == [DeveloperDomainModel] {
        let locale = GetDevelopersLocaleDataSource(realm: realm)
        let remote = GetDevelopersRemoteDataSource(endpoint: Endpoints.Gets.developers.url)
    
        let mapper = DeveloperTransformer()
              let repository = GetDevelopersRepository(
                  localeDataSource: locale,
                  remoteDataSource: remote,
                  mapper: mapper)
              return Interactor(repository: repository) as! U
    }
    
}

