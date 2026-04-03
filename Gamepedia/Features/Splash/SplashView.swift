//
//  SplashScreen.swift
//  Gamepedia
//
//  Created by User on 02/01/26.
//

import SwiftUI
import Core
import Favorite
import SearchGame
import Games
import Genres
import Developers

struct SplashView: View {
    @State var pushNewView: Bool = false
    @EnvironmentObject var gamePresenter: GamePresenter
    @EnvironmentObject var genrePresenter: GenrePresenter
    @EnvironmentObject var favoritePresenter: GetListPresenter<Any, Favorite.DetailGameDomainModel, Interactor<Any, [Favorite.DetailGameDomainModel], GetFavoritiesRepository<GetFavoriteLocaleDataSource, FavoriteTransformer>>>
    @EnvironmentObject var searchPresenter: GetListPresenter<Any, SearchDomainModel, Interactor<Any, [SearchDomainModel], GetSearchRepository<GetSearchRemoteDataSource, SearchTransformer>>>
    @EnvironmentObject var developerPresenter: GetListPresenter<Any, DeveloperDomainModel, Interactor<Any, [DeveloperDomainModel], GetDevelopersRepository<GetDevelopersLocaleDataSource, GetDevelopersRemoteDataSource, DeveloperTransformer>>>
    
    var body: some View {
        NavigationView {
            NavigationLink(isActive: $pushNewView) {
                HomeView(
                    gamePresenter: gamePresenter,
                    genrePresenter: genrePresenter,
                    favoritePresenter: favoritePresenter,
                    searchPresenter: searchPresenter,
                    developerPresenter: developerPresenter
                )
            } label: {
                SplashContent()
            }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                    pushNewView = true
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(.stack)
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SplashContent: View {
    @State var isAnimating = true
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Text("Gamepedia")
                .font(.system(size: 40))
                .foregroundColor(.white)
                .animation(
                    Animation.easeInOut(duration: 1)
                        .repeatForever(autoreverses: true),
                    value: isAnimating
                ).onAppear(perform: {
                    isAnimating.toggle()
                })
            
            Spacer()
        }
        .background(.black)
        .preferredColorScheme(.dark)
    }
}
