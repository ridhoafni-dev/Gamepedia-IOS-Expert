//
//  GenrePresenter.swift
//  Genres
//
//  Created by User on 25/02/26.
//


import Combine
import SwiftUI
public class GenrePresenter: ObservableObject {
    private var cancellables: Set<AnyCancellable> = []
    private let useCase: GenreUseCase

    @Published public var genres: [GenreDomainModel] = []
    @Published public var detailGenre: GenreDomainModel? = nil

    @Published public var errorMessage: String = ""
    @Published public var loadingState: Bool = false

    public init(useCase: GenreUseCase) {
        self.useCase = useCase
    }

    public func getGenres() {
        loadingState = true
        useCase.getListGenres()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false
                }
            }, receiveValue: { genres in
                self.genres = genres
            })
            .store(in: &cancellables)
    }

    public func getDetailGenre(id: Int) {
        loadingState = true
        useCase.getDetailGenre(id: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.loadingState = false

                }
            }, receiveValue: { detail in
                self.detailGenre = detail
            })
            .store(in: &cancellables)
    }

}
