//
//  BottomSection.swift
//  Gamepedia
//
//  Created by User on 12/01/26.
//


import Games
import SkeletonUI
import SwiftUI
struct BottomSection: View {
    @ObservedObject var presenter: GamePresenter
    @State private var htmlHeight: CGFloat = 100

    var body: some View {
        VStack(alignment: .leading) {

            Text("Genres")
                .font(.system(size: 24))
                .foregroundColor(.yellow)

            HStack {
                if presenter.detailGame?.genres != nil {
                    ForEach((presenter.detailGame?.genres)!, id: \.self.id) {
                        genre in
                        VStack {
                            Text(genre.name)
                                .font(.system(size: 14))
                                .fontWeight(.bold)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 15)
                                .foregroundColor(.white)
                                .background(Color.yellow)
                                .cornerRadius(.infinity)
                                .lineLimit(1)
                        }
                    }
                }
            }

            Text("About")
                .font(.system(size: 24))
                .foregroundColor(.yellow)
                .padding(.top, 20)

            HTMLStringView(
                htmlContent: presenter.detailGame?.description ?? "-",
                contentHeight: $htmlHeight
            )
            .frame(height: htmlHeight)
            .animation(.easeInOut(duration: 0.3), value: htmlHeight)

            Text("Platform")
                .font(.system(size: 24))
                .foregroundColor(.yellow)

            if presenter.detailGame?.platforms != nil {
                LazyVStack {
                    ForEach(
                        (presenter.detailGame?.platforms)!,
                        id: \.platform?.id
                    ) { platformData in
                        PlatformItem(
                            released_at: presenter.detailGame?.released,
                            platform: platformData.platform
                        )

                    }
                }
            }

        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
    }
}
