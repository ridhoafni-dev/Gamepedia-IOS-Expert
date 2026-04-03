//
//  GetGamesRepository.swift
//  Game
//
//  Created by User on 31/01/26.
//

import Combine
import ObjectiveC

public class GetGamesRepository: NSObject {
    public typealias GamepediaInstance = (
        GetGameLocaleDataSource, GetGamesRemoteDataSource
    ) -> GetGamesRepository

    let remote: GetGamesRemoteDataSource
    let locale: GetGameLocaleDataSource

    public init(
        remote: GetGamesRemoteDataSource,
        locale: GetGameLocaleDataSource
    ) {
        self.remote = remote
        self.locale = locale
    }

    public func getDiscoveryGames(sortFromBest: Bool) -> AnyPublisher<
        [GameDomainModel], Error
    > {
        return self.remote.getDiscoveryGames(sortFromBest: sortFromBest)
            .map {
                GameTransformer.mapGameResponsesToDomains(input: $0)
            }.eraseToAnyPublisher()
    }

    public func getFewDiscoveryGames() -> AnyPublisher<[DetailGameDomainModel], Error>
    {
        return self.locale.getBestRatingGames()
            .flatMap { result -> AnyPublisher<[DetailGameDomainModel], Error> in
                return self.remote.getFewDiscoveryGames()
                    .map {
                        DetailGameTransformer.mapDetailGameResponseToEntities(
                            input: $0
                        )
                    }
                    .flatMap { self.locale.addGames(from: $0) }
                    .filter { $0 }
                    .flatMap { _ in
                        self.locale.getBestRatingGames()
                            .map {
                                DetailGameTransformer
                                    .mapDetailGameEntitiesToDomains(input: $0)
                            }
                    }
                    .eraseToAnyPublisher()

            }.eraseToAnyPublisher()
    }
    
    public func getGameDetail(id: Int, isAdd: Bool = false) -> AnyPublisher<DetailGameDomainModel, Error> {
        return self.locale.getDetailGame(id: id)
            .flatMap { result -> AnyPublisher<DetailGameDomainModel, Error> in
                if result.desc == "" {
                    return self.remote.getGameDetails(id: id)
                    .map { DetailGameTransformer.mapDetailGameResponsesToEntities(input: $0)  }
                        .flatMap { res in
                            if(isAdd) {
                                return self.locale.addGame(from: res)
                            } else {
                                return self.locale.updateGames(gameEntity: res)
                            }
                        }
                        .filter { $0 }
                        .flatMap { _ in self.locale.getDetailGame(id: id)
                            .map {
                                DetailGameTransformer.mapDetailGameEntityToDomain(input: $0)
                            }
                        }.eraseToAnyPublisher()
                } else {
                    return self.locale.getDetailGame(id: id)
                        .map { DetailGameTransformer.mapDetailGameEntityToDomain(input: $0) }
                        .eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }

}
