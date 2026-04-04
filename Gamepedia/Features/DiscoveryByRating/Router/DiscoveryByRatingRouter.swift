//
//  DiscoveryByRatingRouter.swift
//  Gamepedia
//
//  Created by User on 03/01/26.
//



import Combine
import Core
import Favorite
import Foundation
import Games
import SwiftUI
class DiscoveryByRatingRouter {

    @ObservedObject var presenter: GamePresenter
    @ObservedObject var favoritePresenter: GetListPresenter<Any, Favorite.DetailGameDomainModel, Interactor<Any, [Favorite.DetailGameDomainModel], GetFavoritiesRepository<GetFavoriteLocaleDataSource, FavoriteTransformer>>>

    init(presenter: GamePresenter, favoritePresenter: GetListPresenter<Any, Favorite.DetailGameDomainModel, Interactor<Any, [Favorite.DetailGameDomainModel], GetFavoritiesRepository<GetFavoriteLocaleDataSource, FavoriteTransformer>>>) {
        self.presenter = presenter
        self.favoritePresenter = favoritePresenter
    }

    func makeDetailView(for id: Int, isAdd: Bool = false) -> some View {
        return DetailView(presenter: presenter, favoritePresenter: favoritePresenter, gameId: id, isAdd: isAdd)
    }

}
