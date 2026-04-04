//
//  GamePresenter.swift
//  Game
//
//  Created by User on 08/02/26.
//

import Combine
import Foundation

public class GamePresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let useCase: GameUseCase

    @Published public var gamesByRating: [GameDomainModel] = []
    @Published public var games: [DetailGameDomainModel] = []
    @Published public var detailGame: DetailGameDomainModel?
    @Published public var gameUpdated: DetailGameDomainModel?

    public var options: [GenreFilterDropdownOptionDomainModel]?

    @Published public var errorMessage: String = ""
    @Published public var loadingState: Bool = false
    @Published public var discoveryLoadingState: Bool = false

    private static var uniqueKey: String {
        UUID().uuidString
    }

    public init(useCase: GameUseCase) {
        self.useCase = useCase
        self.options = [
            GenreFilterDropdownOptionDomainModel(
                key: GamePresenter.uniqueKey,
                value: "Best Rating"
            ),
            GenreFilterDropdownOptionDomainModel(
                key: GamePresenter.uniqueKey,
                value: "Worst Rating"
            ),
        ]
    }

    public func getGames() {
        discoveryLoadingState = true
        useCase.getFewDiscoveryGame()
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure:
                        self.errorMessage = String(describing: completion)
                    case .finished:
                        self.discoveryLoadingState = false
                    }
                },
                receiveValue: { games in
                    self.games = games
                }
            )
            .store(in: &cancellables)
    }

    public func getGamesFromBest(isBest: Bool) {
        loadingState = true
        useCase.getAllDiscoveryGame(sortFromBest: isBest)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure:
                        self.errorMessage = String(describing: completion)
                    case .finished:
                        self.loadingState = false
                    }
                },
                receiveValue: { games in
                    self.gamesByRating = games
                }
            )
            .store(in: &cancellables)
    }

    public func getDetailGame(id: Int, isAdd: Bool = false) {
        loadingState = true
        useCase.getDetailGame(id: id, isAdd: isAdd)
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure:
                        self.errorMessage = String(describing: completion)
                    case .finished:
                        self.loadingState = false
                    }
                },
                receiveValue: { detail in
                    self.detailGame = detail
                }
            )
            .store(in: &cancellables)
    }

}
