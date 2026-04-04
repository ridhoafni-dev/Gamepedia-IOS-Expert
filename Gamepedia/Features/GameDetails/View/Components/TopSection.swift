//
//  TopSection.swift
//  Gamepedia
//
//  Created by User on 10/01/26.
//

import Games
import Kingfisher
import SwiftUI

struct TopSection: View {
    @ObservedObject var presenter: GamePresenter

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                KFImage.url(
                    URL(string: (presenter.detailGame?.backgroundImage) ?? "")
                )
                .placeholder {
                    ProgressView()
                }
                .cacheOriginalImage()
                .fade(duration: 0.25)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .frame(
                    maxWidth: geometry.size.width,
                    maxHeight: geometry.size.height
                )
                .mask(
                    LinearGradient(
                        gradient: Gradient(
                            colors: [
                                Color.black,
                                Color.black,
                                Color.black,
                                Color.black.opacity(0),
                            ]
                        ),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .overlay {
                    HeaderOverlay(game: presenter.detailGame)
                }

            }
        }.frame(height: 450.0)
    }
}
