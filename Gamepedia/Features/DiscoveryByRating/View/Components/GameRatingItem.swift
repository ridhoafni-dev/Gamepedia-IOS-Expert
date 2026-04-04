//
//  GameRatingItem.swift
//  Gamepedia
//
//  Created by User on 15/01/26.
//

import Core
import Games
import Kingfisher
import SwiftUI

struct GameRatingItem: View {
    @ObservedObject var presenter: GamePresenter
    @State var game: GameDomainModel?

    var body: some View {
        HStack {
            KFImage.url(URL(string: (game?.backgroundImage) ?? ""))
                .placeholder {
                    ProgressView()
                }
                .cacheOriginalImage()
                .fade(duration: 0.25)
                .resizable()
                .cornerRadius(8)
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .clipped()

            HStack {
                VStack(alignment: .leading) {
                    Text(game?.name ?? "-")
                        .font(.system(size: 18))
                        .foregroundColor(.yellow)
                        .lineLimit(1)

                    if let releaseDate = game?.released {
                        Text("Released on \(dateFormat(dateTxt: releaseDate))")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    } else {
                        Text("Unknow release date")
                            .foregroundColor(
                                Color(
                                    red: 241 / 255,
                                    green: 242 / 255,
                                    blue: 246 / 255
                                )
                            )
                            .font(.system(size: 12))
                    }

                }

                HStack {
                    Label("", systemImage: "star.fill")
                        .labelStyle(.iconOnly)
                        .foregroundColor(.yellow)
                        .font(.system(size: 12))

                    Text("\(game?.rating ?? 0.0, specifier: "%.2f")")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 14))

                    Text("| Total Review \(game?.reviewsCount ?? 0)")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 14))

                }
            }.frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 10)
    }
}
