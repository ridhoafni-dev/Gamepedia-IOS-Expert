import Core
import Favorite
import Games
import SwiftUI

typealias DetailGenreFavoritePresenterType = GetListPresenter<
  Any,
  Favorite.DetailGameDomainModel,
  Interactor<
    Any,
    [Favorite.DetailGameDomainModel],
    GetFavoritiesRepository<GetFavoriteLocaleDataSource, FavoriteTransformer>
  >
>

class DetailGenreRouter {
    @ObservedObject var presenter: GamePresenter
    @ObservedObject var favoritePresenter: DetailGenreFavoritePresenterType

    init(
        presenter: GamePresenter,
        favoritePresenter: DetailGenreFavoritePresenterType
    ) {
        self.presenter = presenter
        self.favoritePresenter = favoritePresenter
    }

    func makeDetailView(for id: Int, isAdd: Bool = false) -> some View {
        return DetailView(
            presenter: presenter,
            favoritePresenter: favoritePresenter,
            gameId: id,
            isAdd: isAdd
        )
    }
}
