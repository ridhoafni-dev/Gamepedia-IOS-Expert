import Combine
//
//  HomeTab.swift
//  Gamepedia
//
//  Created by User on 03/01/26.
//import Combine
import Core
import Developers
import Favorite
import Games
import Genres
import SwiftUI

struct HomeTab: View {
    @ObservedObject var genrePresenter: GenrePresenter
    @ObservedObject var favoritePresenter: FavoritePresenterType
    @ObservedObject var developerPresenter: DeveloperPresenterType
    @ObservedObject var gamePresenter: GamePresenter
    @State var game: Games.DetailGameDomainModel?
    var body: some View {
        let router = HomeRouter(
            gamePresenter: gamePresenter,
            favoritePresenter: favoritePresenter,
            genrePresenter: genrePresenter
        )

        ZStack {
            if gamePresenter.discoveryLoadingState {
                ZStack {
                    ProgressView()
                }
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
                .background(.black)
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        Group {
                            HStack {
                                Text("Gamepedia").font(.gameHeader)
                                Spacer()
                                Image("user")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            }
                        }

                        Spacer().frame(height: 20)

                        Group {
                            HStack {
                                TitleSubtitle(
                                    title: "Discovery",
                                    subtitle: "Based on best rating"
                                )
                                Spacer()
                                NavigationLink(
                                    destination:
                                        router.makeDiscoverByRatingView()
                                ) {
                                    Image(
                                        systemName: "arrow.right.circle"
                                    )
                                    .tint(Color.yellow)
                                }.buttonStyle(PlainButtonStyle())
                            }
                        }

                        ScrollView(.horizontal, showsIndicators: false) {
                            if gamePresenter.discoveryLoadingState {
                                ZStack {
                                    ProgressView()
                                }
                                .frame(
                                    width: 200,
                                    height: 230
                                )
                            } else {
                                LazyHStack {
                                    ForEach(
                                        gamePresenter.games,
                                        id: \.id
                                    ) { game in
                                        ZStack {
                                            NavigationLink(
                                                destination:
                                                    router.makeDetailView(
                                                        for: game.id ?? 0
                                                    )
                                            ) {
                                                GameItem(
                                                    favoritePresenter:
                                                        favoritePresenter,
                                                    gamePresenter:
                                                        gamePresenter,
                                                    game: game
                                                )
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }.padding(8)
                                    }
                                }
                            }
                        }

                        Spacer().frame(height: 20)

                        //Genre section
                        Group {
                            TitleSubtitle(
                                title: "Genres",
                                subtitle: "Find your favorite genre here"
                            )
                            GenreGridView(
                                presenter: genrePresenter,
                                router: router
                            )
                        }

                        //Developer section
                        Group {
                            TitleSubtitle(
                                title: "Developers",
                                subtitle: "Find your favorite developer here"
                            )

                            ScrollView(.vertical, showsIndicators: false) {
                                LazyVStack {
                                    ForEach(
                                        developerPresenter.list,
                                        id: \.id
                                    ) { developer in
                                        DeveloperItem(
                                            developer: developer,
                                            presenter: developerPresenter,
                                            genrePresenter: genrePresenter,
                                            favoritePresenter:
                                                favoritePresenter,
                                            gamePresenter: gamePresenter
                                        )
                                    }
                                }
                            }.frame(maxHeight: 800)
                        }

                    }.frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
                    .padding(
                        EdgeInsets.init(
                            top: 16,
                            leading: 20,
                            bottom: 50,
                            trailing: 20
                        )
                    )
                }
            }
        }.onAppear {
            gamePresenter.getGames()
            genrePresenter.getGenres()
            developerPresenter.getList(request: nil)

            gamePresenter.objectWillChange.send()
            genrePresenter.objectWillChange.send()
            developerPresenter.objectWillChange.send()

            //tab bar appearance
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}
