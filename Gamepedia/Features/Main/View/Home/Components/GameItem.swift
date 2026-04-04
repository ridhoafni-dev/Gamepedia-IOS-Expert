//
//  GameItem.swift
//  Gamepedia
//
//  Created by User on 05/01/26.
//
import Core
import Favorite
import Games
import Kingfisher
import SkeletonUI
import SwiftUI

struct GameItem: View {
    @ObservedObject var favoritePresenter: FavoritePresenterType
    @ObservedObject var gamePresenter: GamePresenter
    @State var game: Games.DetailGameDomainModel
    @State private var _isFavorite: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            KFImage.url(URL(string: (game.backgroundImage) ?? ""))
                .placeholder {
                    ProgressView()
                }
                .cacheOriginalImage()
                .resizable()
                .clipped()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 150)
                .cornerRadius(10)
            HStack {
                VStack(alignment: .leading) {
                    if game.released != "" {
                        Text(
                            "Released on \(dateFormat(dateTxt: game.released!))"
                        )
                        .font(.gameCaption)
                        .foregroundColor(
                            Color(
                                red: 209 / 255,
                                green: 209 / 255,
                                blue: 209 / 255
                            )
                        )
                    } else {
                        Text("Unknown released date")
                            .font(.gameCaption)
                            .foregroundColor(
                                Color(
                                    red: 209 / 255,
                                    green: 209 / 255,
                                    blue: 209 / 255
                                )
                            )
                    }

                    Spacer().frame(height: 3)
                    Text(game.name)
                        .font(.gameBody)
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)

                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                            .font(.system(size: 12))
                        Text(String(format: "%.2f", game.rating!))
                            .font(.gameCaption)
                            .foregroundColor(.white)
                    }
                }

                Button(action: {
                    _isFavorite = !_isFavorite
                    favoritePresenter.updateFavorite(
                        request: nil,
                        id: game.id!,
                        isFavorite: _isFavorite
                    )
                    gamePresenter.getGames()
                }) {
                    Image(
                        systemName: _isFavorite == true
                            ? "heart.circle.fill" : "heart.circle"
                    )
                    .font(.system(size: 18))
                    .tint(_isFavorite == true ? .red : .gray)
                }
            }
            .padding(10)
            Spacer()
        }
        .frame(
            width: 200,
            height: 230
        )
        .background(Color(red: 67 / 255, green: 67 / 255, blue: 67 / 255))
        .cornerRadius(10)
        .onAppear {
            _isFavorite = game.isFavorite ?? false
        }
    }
}
