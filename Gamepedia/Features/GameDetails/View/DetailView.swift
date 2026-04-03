//
//  GameDetailView.swift
//  Gamepedia
//
//  Created by User on 03/01/26.
//

import SwiftUI

import Core
import Games
import Favorite

struct DetailView: View {
    @ObservedObject var presenter: GamePresenter
    @ObservedObject var favoritePresenter: GetListPresenter<Any, Favorite.DetailGameDomainModel, Interactor<Any, [Favorite.DetailGameDomainModel], GetFavoritiesRepository<GetFavoriteLocaleDataSource, FavoriteTransformer>>>
    
    @State var gameId: Int
    @State var isAdd: Bool
    
    var body: some View {
        DetailContent(presenter: presenter, favoritePresenter: favoritePresenter, gameId: gameId, isAdd: isAdd)
    }
}
