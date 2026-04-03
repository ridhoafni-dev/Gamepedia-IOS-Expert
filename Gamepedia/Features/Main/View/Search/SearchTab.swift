//
//  SearchTab.swift
//  Gamepedia
//
//  Created by User on 07/01/26.
//

import SwiftUI
import UIKit

import Games
import SearchGame
import Core
import Favorite
import Genres
import Combine
import Lottie

typealias SearchPresenterType = GetListPresenter<Any, SearchDomainModel, Interactor<Any, [SearchDomainModel], GetSearchRepository<GetSearchRemoteDataSource, SearchTransformer>>>

struct SearchTab: View {
    @State var pushNewView: Bool = false
    @ObservedObject var presenter: SearchPresenterType
    @ObservedObject var genrePresenter: GenrePresenter
    @ObservedObject var favoritePresenter: GetListPresenter<Any, Favorite.DetailGameDomainModel, Interactor<Any, [Favorite.DetailGameDomainModel], GetFavoritiesRepository<GetFavoriteLocaleDataSource, FavoriteTransformer>>>
    @ObservedObject var gamePresenter: GamePresenter
    
    @State var keyword: String = ""
    @State var isLoading = false
    
    var body: some View {
        let router = HomeRouter(gamePresenter: gamePresenter, favoritePresenter: favoritePresenter, genrePresenter: genrePresenter)
        VStack(alignment: .leading) {
            Text("Search")
                .font(.system(size: 24))
                .foregroundColor(.yellow)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            ZStack {
                TextField(
                    "Enter title here...",
                    text: $keyword
                )
                .onSubmit {
                    presenter.getSearchList(request: nil, keyword: keyword)
                }
                .disableAutocorrection(true)
            }
            .padding(10)
            .background(Color(red: 68/255, green: 68/255, blue: 68/255))
            
            if(presenter.isLoading) {
                Loading()
            } else {
                if(!presenter.list.isEmpty) {
                    ScrollView(.vertical, showsIndicators: false){
                        LazyVStack{
                            ForEach(presenter.list, id: \.self.id){ game in
                                NavigationLink(
                                    destination: router.makeDetailView(for: game.id!, isAdd: false)
                                ) {
                                    SearchItem(presenter: presenter, game: game)
                                }.buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                } else {
                    VStack(alignment: .center) {
                        Spacer()
                        ZStack {
                            Circle()
                                .fill(.white)
                                .frame(width: 100 * 2, height: 100 * 2)
                            LottieView(
                                name: "no_result",
                                loopMode: .loop
                              )
                              .frame(
                                width: 150,
                                height: 150,
                                alignment: .center
                              )
                        }
                        Spacer()
                        Text("No data found")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(
                                Font.custom("VerminVibesV", size: 24)
                            )
                        Spacer()
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
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
          )
        .onAppear {
            self.presenter.objectWillChange.send()
            
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithDefaultBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}
