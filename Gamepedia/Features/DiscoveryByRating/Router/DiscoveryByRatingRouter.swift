//
//  DiscoveryByRatingRouter.swift
//  Gamepedia
//
//  Created by User on 03/01/26.
//

import SwiftUI
import Foundation

import Core
import Games
import Favorite
import Combine

typealias DiscoveryFavoritePresenterType = GetListPresenter<
  Any,
  Favorite.DetailGameDomainModel,
  Interactor<
    Any,
    [Favorite.DetailGameDomainModel],
    GetFavoritiesRepository<GetFavoriteLocaleDataSource, FavoriteTransformer>
  >
>

class DiscoveryByRatingRouter {
    
    @ObservedObject var presenter: GamePresenter
    @ObservedObject var favoritePresenter: DiscoveryFavoritePresenterType
    
    init(
        presenter: GamePresenter,
        favoritePresenter: DiscoveryFavoritePresenterType
    ) {
        self.presenter = presenter
        self.favoritePresenter = favoritePresenter
    }

    func makeDetailView(for id: Int, isAdd: Bool = false) -> some View {
        return DetailView(presenter: presenter, favoritePresenter: favoritePresenter, gameId: id, isAdd: isAdd)
    }
  
}
