import Core
import Favorite
import Foundation
import Games
import Genres
import SwiftUI

typealias HomeFavoritePresenterType = GetListPresenter<
  Any,
  Favorite.DetailGameDomainModel,
  Interactor<
    Any,
    [Favorite.DetailGameDomainModel],
    GetFavoritiesRepository<GetFavoriteLocaleDataSource, FavoriteTransformer>
  >
>

class HomeRouter {

    @ObservedObject var gamePresenter: GamePresenter
    @ObservedObject var favoritePresenter: HomeFavoritePresenterType
    @ObservedObject var genrePresenter: GenrePresenter

    init(
        gamePresenter: GamePresenter,
        favoritePresenter: HomeFavoritePresenterType,
        genrePresenter: GenrePresenter
    ) {
        self.gamePresenter = gamePresenter
        self.favoritePresenter = favoritePresenter
        self.genrePresenter = genrePresenter
    }

    func makeDetailView(
        for id: Int,
        isAdd: Bool = false
    ) -> some View {
        return DetailView(
            presenter: gamePresenter,
            favoritePresenter: favoritePresenter,
            gameId: id,
            isAdd: isAdd
        )
    }

    func makeDiscoverByRatingView() -> some View {
        return DiscoveryByRatingView(
            presenter: gamePresenter,
            favoritePresenter: favoritePresenter
        )
    }

    func makeDetailGenreView(for id: Int) -> some View {
        return DetailGenreView(
            presenter: genrePresenter,
            gamePresenter: gamePresenter,
            favoritePresenter: favoritePresenter,
            genreId: id
        )
    }
}
