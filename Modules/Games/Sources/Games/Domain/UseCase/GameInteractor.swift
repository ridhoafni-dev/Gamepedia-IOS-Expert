//
//  GameUseCae.swift
//  Game
//
//  Created by User on 05/02/26.
//

import Combine
import Foundation

public protocol GameUseCase {
    func getFewDiscoveryGame() -> AnyPublisher<[DetailGameDomainModel], Error>
    func getAllDiscoveryGame(sortFromBest: Bool) -> AnyPublisher<
        [GameDomainModel], Error
    >
    func getDetailGame(id: Int, isAdd: Bool) -> AnyPublisher<
        DetailGameDomainModel, Error
    >
}

public class GameInteractor: GameUseCase {
    private let repository: GetGamesRepository
    private var isAdd: Bool = false

    public init(repository: GetGamesRepository, isAdd: Bool) {
        self.repository = repository
        self.isAdd = isAdd
    }

    public func getFewDiscoveryGame() -> AnyPublisher<
        [DetailGameDomainModel], Error
    > {
        return repository.getFewDiscoveryGames()
    }

    public func getAllDiscoveryGame(sortFromBest: Bool) -> AnyPublisher<
        [GameDomainModel], Error
    > {
        return repository.getDiscoveryGames(sortFromBest: sortFromBest)
    }

    public func getDetailGame(id: Int, isAdd: Bool) -> AnyPublisher<
        DetailGameDomainModel, Error
    > {
        return repository.getGameDetail(id: id, isAdd: isAdd)
    }
}
