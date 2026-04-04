//
//  GameFavoriteItem.swift
//  Gamepedia
//
//  Created by User on 09/01/26.
//

import CachedAsyncImage
import Core
import Favorite
import Games
import Genres
import SwiftUI

typealias GameFavoritePresenterType = GetListPresenter<
    Any,
    Favorite.DetailGameDomainModel,
    Interactor<
        Any,
        [Favorite.DetailGameDomainModel],
        GetFavoritiesRepository<
            GetFavoriteLocaleDataSource, FavoriteTransformer
        >
    >
>

struct GameFavoriteItem: View {
    @ObservedObject var presenter: GameFavoritePresenterType
    @State var game: Favorite.DetailGameDomainModel?

    var body: some View {
        HStack {
            CachedAsyncImage(url: URL(string: (game?.backgroundImage) ?? "")) {
                image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .cornerRadius(4)
            .scaledToFit()
            .frame(width: 80, height: 80)
            .padding(.top)

            HStack {
                VStack(alignment: .leading) {
                    Text(game?.name ?? "-")
                        .lineLimit(1)
                        .font(.system(size: 18))
                        .foregroundColor(.yellow)

                    if let releaseDate = game?.released, !releaseDate.isEmpty {
                        Text("Release on \(dateFormat(dateTxt: releaseDate))")
                            .font(.system(size: 12))
                            .foregroundColor(
                                Color(
                                    red: 241 / 255,
                                    green: 242 / 255,
                                    blue: 246 / 255
                                )
                            )
                    } else {
                        Text("-")
                            .foregroundColor(
                                Color(
                                    red: 241 / 255,
                                    green: 242 / 255,
                                    blue: 246 / 255
                                )
                            )
                    }

                    HStack {
                        Label("", systemImage: "star.fill")
                            .labelStyle(.iconOnly)
                            .foregroundColor(.yellow)
                            .font(.system(size: 12))

                        Text("\(game?.rating ?? 0.0, specifier: "%.2f")")
                            .foregroundColor(.white)
                            .font(.system(size: 14))
                            .fontWeight(.bold)

                        // Convert Int? to a String, or show "-"
                        Text(
                            "| Score: \(game?.reviewsCount.map(String.init) ?? "-")"
                        )
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 10)
        }

    }
}
