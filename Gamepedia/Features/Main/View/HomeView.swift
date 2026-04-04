//
//  HomeView.swift
//  Gamepedia
//
//  Created by User on 03/01/26.
//
import Core
import Developers
import Favorite
import Games
import Genres
import SearchGame
import SwiftUI

struct HomeView: View {

    @ObservedObject var gamePresenter: GamePresenter
    @ObservedObject var genrePresenter: GenrePresenter
    @ObservedObject var favoritePresenter: FavoritePresenterType
    @ObservedObject var searchPresenter: SearchPresenterType
    @ObservedObject var developerPresenter: DeveloperPresenterType

    @State var tabSelection: Tabs = .tabHome

    enum Tabs {
        case tabHome, tabSearch, tabFavorite, tabProfile
    }
    var body: some View {
        NavigationView {
            TabView(selection: $tabSelection) {
                HomeTab(
                    genrePresenter: genrePresenter,
                    favoritePresenter: favoritePresenter,
                    developerPresenter: developerPresenter,
                    gamePresenter: gamePresenter
                  )
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(Tabs.tabHome)

                SearchTab(
                    presenter: searchPresenter,
                    genrePresenter: genrePresenter,
                    favoritePresenter: favoritePresenter,
                    gamePresenter: gamePresenter
                )
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(Tabs.tabSearch)

                FavoriteTab(
                    presenter: favoritePresenter,
                    genrePresenter: genrePresenter,
                    gamePresenter: gamePresenter
                )
                    .tabItem {
                        Image(systemName: "heart.circle.fill")
                        Text("Favorites")
                    }
                    .tag(Tabs.tabFavorite)

                ProfileTab()
                    .tabItem {
                        Image(systemName: "person.circle")
                        Text("Profile")
                    }
                    .tag(Tabs.tabProfile)
            }
            .accentColor(.yellow)
        }
        .navigationBarBackButtonHidden(true)
        .navigationViewStyle(.stack)
    }
}
