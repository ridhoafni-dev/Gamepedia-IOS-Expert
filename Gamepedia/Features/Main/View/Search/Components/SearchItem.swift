//
//  SearchItem.swift
//  Gamepedia
//
//  Created by User on 08/01/26.
//

import CachedAsyncImage
import Core
import Games
import Kingfisher
import SearchGame
import SkeletonUI
import SwiftUI

struct SearchItem: View {
    @ObservedObject var presenter: SearchPresenterType
    @State var game: SearchDomainModel?

    var body: some View {
        HStack {

            CachedAsyncImage(
                url: URL(string: (game?.backgroundImage) ?? "")
            ) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .cornerRadius(8)
            .scaledToFit()
            .frame(width: 80, height: 80)
            .padding(.top)

            HStack {
                VStack(alignment: .leading) {
                    Text(game?.name)
                        .lineLimit(1)

                    if let releaseDate = game?.released {
                        Text("Release on \(dateFormat(dateTxt: releaseDate))")
                    } else {
                        Text("Unknow release date")
                    }

                    HStack {
                        Label("", systemImage: "star.fill")
                            .labelStyle(.iconOnly)

                        Text("\(game?.rating ?? 0.0, specifier: "%.2f")")

                        Text("| Score: \(game?.score ?? "-")")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 10)
        }
    }
}


