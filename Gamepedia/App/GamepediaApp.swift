//
//  GamepediaApp.swift
//  Gamepedia
//
//  Created by User on 29/12/25.
//

import Core
import Developers
import Favorite
import Games
import Genres
import SearchGame
import SwiftUI

@main
struct GamepediaApp: App {
    @Environment(\.scenePhase) var scenePhase

    // Keep a single Injection instance
    private let injection = Injection()

    // Create use cases and presenters outside the ViewBuilder to avoid compiler crashes
    private let genrePresenter: GenrePresenter
    private let gamePresenter: GamePresenter

    private let developerPresenter:
        GetListPresenter<
            Any,
            DeveloperDomainModel,
            Interactor<
                Any,
                [DeveloperDomainModel],
                GetDevelopersRepository<
                    GetDevelopersLocaleDataSource,
                    GetDevelopersRemoteDataSource,
                    DeveloperTransformer
                >
            >
        >

    private let favoritePresenter:
        GetListPresenter<
            Any,
            Favorite.DetailGameDomainModel,
            Interactor<
                Any,
                [Favorite.DetailGameDomainModel],
                GetFavoritiesRepository<
                    GetFavoriteLocaleDataSource,
                    FavoriteTransformer
                >
            >
        >

    private let searchPresenter:
        GetListPresenter<
            Any,
            SearchDomainModel,
            Interactor<
                Any,
                [SearchDomainModel],
                GetSearchRepository<
                    GetSearchRemoteDataSource,
                    SearchTransformer
                >
            >
        >

    init() {
        // Build use cases
        let genreUseCase: GenreInteractor = injection.provideGenre()
        let gameUseCase: GameInteractor = injection.provideGame()

        let developerUseCase:
            Interactor<
                Any,
                [DeveloperDomainModel],
                GetDevelopersRepository<
                    GetDevelopersLocaleDataSource,
                    GetDevelopersRemoteDataSource,
                    DeveloperTransformer
                >
            > = injection.provideDeveloper()

        let favoriteUseCase:
            Interactor<
                Any,
                [Favorite.DetailGameDomainModel],
                GetFavoritiesRepository<
                    GetFavoriteLocaleDataSource,
                    FavoriteTransformer
                >
            > = injection.provideFavorite()

        let searchUseCase:
            Interactor<
                Any,
                [SearchDomainModel],
                GetSearchRepository<
                    GetSearchRemoteDataSource,
                    SearchTransformer
                >
            > = injection.provideSearch()

        // Build presenters
        self.genrePresenter = GenrePresenter(useCase: genreUseCase)
        self.gamePresenter = GamePresenter(useCase: gameUseCase)
        self.developerPresenter = GetListPresenter(useCase: developerUseCase)
        self.favoritePresenter = GetListPresenter(useCase: favoriteUseCase)
        self.searchPresenter = GetListPresenter(useCase: searchUseCase)
    }

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(gamePresenter)
                .environmentObject(genrePresenter)
                .environmentObject(favoritePresenter)
                .environmentObject(searchPresenter)
                .environmentObject(developerPresenter)
        }
        .onChange(of: scenePhase) {
            // Handle scene phase changes if needed
        }
    }
}
