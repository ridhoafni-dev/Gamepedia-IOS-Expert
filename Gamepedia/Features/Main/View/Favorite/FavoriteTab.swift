//
//  FavoriteTab.swift
//  Gamepedia
//
//  Created by User on 08/01/26.
//

import SwiftUI
import Combine

import Core
import Favorite
import Games
import Genres

struct FavoriteTab: View {
    @ObservedObject var presenter: GetListPresenter<Any, Favorite.DetailGameDomainModel, Interactor<Any, [Favorite.DetailGameDomainModel], GetFavoritiesRepository<GetFavoriteLocaleDataSource, FavoriteTransformer>>>
      @ObservedObject var genrePresenter: GenrePresenter
      @ObservedObject var gamePresenter: GamePresenter
    
    var body: some View {
        let router = HomeRouter(gamePresenter: gamePresenter, favoritePresenter: presenter, genrePresenter: genrePresenter)

        ZStack {
            if presenter.isLoading {
                Loading()
            } else {
                VStack(alignment: .leading) {
                    Text("My Favorites")
                        .font(.system(size: 24))
                        .foregroundColor(.yellow)
                        .fontWeight(.bold)
                    ScrollView {
                        if(!presenter.list.isEmpty){
                            LazyVStack(alignment: .leading){
                                ForEach(presenter.list, id: \.self.id){ game in
                                    NavigationLink(
                                       destination: router.makeDetailView(for: game.id ?? 0, isAdd: true)
                                     ) {
                                       GameFavoriteItem(presenter: presenter, game: game)
                                     }
                                }
                            }
                            .padding(.top, 10)
                            .zIndex(-1)
                        } else {
                            VStack(alignment: .center) {
                                Text("No favorite found")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .font(.system(size: 24))
                            }.frame(
                                minWidth: 0,
                                maxWidth: .infinity,
                                minHeight: 0,
                                maxHeight: .infinity,
                                alignment: .center
                            )
                        }
                    }
                }
                .padding(16)
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
            }
        }
        .onAppear{
            presenter.getList(request: nil, )
            self.presenter.objectWillChange.send()
              
            //tab bar appearance
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}
