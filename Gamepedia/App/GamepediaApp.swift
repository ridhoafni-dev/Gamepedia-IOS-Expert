//
//  GamepediaApp.swift
//  Gamepedia
//
//  Created by User on 29/12/25.
//

import SwiftUI
import Genres
import Games
import Favorite
import Developers
import SearchGame
import Core

@main
struct GamepediaApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            
            let genreUseCase: GenreInteractor = Injection.init().provideGenre()
            let genrePresenter = GenrePresenter(useCase: genreUseCase)
            
            let gameUseCase: GameInteractor = Injection.init().provideGame()
            let gamePresenter = GamePresenter(useCase: gameUseCase)
            
            let developerUseCase: Interactor<
                Any,
                [DeveloperDomainModel],
                GetDevelopersRepository<
                    GetDevelopersLocaleDataSource,
                    GetDevelopersRemoteDataSource,
                    DeveloperTransformer
                >
            > = Injection.init().provideDeveloper()
            
            let developerPresenter = GetListPresenter(useCase: developerUseCase)
            
            let favoriteUseCase: Interactor<
                      Any,
                      [Favorite.DetailGameDomainModel],
                      GetFavoritiesRepository<
                          GetFavoriteLocaleDataSource,
                          FavoriteTransformer
                      >
                    > = Injection.init().provideFavorite()
            
            let favoritePresenter = GetListPresenter(useCase: favoriteUseCase)
            
            let seachUseCase: Interactor<
                Any,
                [SearchDomainModel],
                GetSearchRepository<
                    GetSearchRemoteDataSource,
                    SearchTransformer>
            > = Injection.init().provideSearch()
            let searchPresenter = GetListPresenter(useCase: seachUseCase)
            
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
