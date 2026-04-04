//
//  GameDetailView.swift
//  Gamepedia
//
//  Created by User on 03/01/26.
//

import Core
import Favorite
import Games
import SwiftUI

typealias DetailFavoritePresenterType = GetListPresenter<
  Any,
  Favorite.DetailGameDomainModel,
  Interactor<
    Any,
    [Favorite.DetailGameDomainModel],
    GetFavoritiesRepository<GetFavoriteLocaleDataSource, FavoriteTransformer>
  >
>

struct DetailView: View {
    @ObservedObject var presenter: GamePresenter
    @ObservedObject var favoritePresenter: DetailFavoritePresenterType

    @State var gameId: Int
    @State var isAdd: Bool

    var body: some View {
        DetailContent(
            presenter: presenter,
            favoritePresenter: favoritePresenter,
            gameId: gameId,
            isAdd: isAdd
        )
    }
}
