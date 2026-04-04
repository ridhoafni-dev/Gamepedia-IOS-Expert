//
//  DetailGenreView.swift
//  Gamepedia
//
//  Created by User on 16/01/26.
//

import Combine
import Core
import Favorite
import Games
import Genres
import Kingfisher
import SkeletonUI
import SwiftUI

struct DetailGenreView: View {
    @ObservedObject var presenter: GenrePresenter
    @ObservedObject var gamePresenter: GamePresenter
    @ObservedObject var favoritePresenter: FavoritePresenterType
    @State var genreId: Int

    init(
        presenter: GenrePresenter,
        gamePresenter: GamePresenter,
        favoritePresenter: FavoritePresenterType,
        genreId: Int
    ) {

        self.presenter = presenter
        self.gamePresenter = gamePresenter
        self.genreId = genreId
        self.favoritePresenter = favoritePresenter

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor.black

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }

    var body: some View {
        RootGenreContent(
            presenter: presenter,
            gamePresenter: gamePresenter,
            favoritePresenter: favoritePresenter,
            genreId: genreId
        )
    }
}

struct RootGenreContent: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var presenter: GenrePresenter
    @ObservedObject var gamePresenter: GamePresenter
    @ObservedObject var favoritePresenter: FavoritePresenterType
    var genreId: Int

    @State private var htmlHeight: CGFloat = 100

    var body: some View {
        let router = DetailGenreRouter(
            presenter: gamePresenter,
            favoritePresenter: favoritePresenter
        )
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ZStack {
                        GeometryReader { geometry in
                            KFImage.url(
                                URL(
                                    string: presenter.detailGenre?
                                        .imageBackground ?? ""
                                )
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
                                    gradient: Gradient(colors: [
                                        Color.black,
                                        Color.black,
                                        Color.black,
                                        Color.black.opacity(0),
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .overlay {
                                HeaderGenreOverlay(
                                    name: presenter.detailGenre?.name,
                                    gamesCount: presenter.detailGenre?
                                        .gamesCount
                                )
                            }
                        }

                    }
                    .frame(height: 450.0)

                    Text("About")
                        .font(.system(size: 24))
                        .foregroundColor(.yellow)

                    HTMLStringView(
                        htmlContent: presenter.detailGenre?.desc ?? "-",
                        contentHeight: $htmlHeight
                    )
                    .frame(height: htmlHeight)
                    .animation(.easeInOut(duration: 0.3), value: htmlHeight)
                    .padding(.bottom, 20)

                    Text("Popular Games")
                        .font(.system(size: 24))
                        .foregroundColor(.yellow)

                    if presenter.detailGenre?.games != nil {
                        LazyVStack(alignment: .leading) {
                            ForEach(presenter.detailGenre!.games, id: \.id) {
                                game in
                                ZStack {
                                    NavigationLink(
                                        destination: router.makeDetailView(
                                            for: game.id ?? 0,
                                            isAdd: true
                                        )
                                    ) {
                                        Text(game.name)
                                            .foregroundColor(.white)
                                            .font(.system(size: 16))
                                            .underline()
                                            .padding(.bottom, 10)
                                    }.buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                    }
                }
                .padding(10)
                .navigationBarTitle("Genre Details")
                .padding(.bottom, 50)
            }
            .background(Color.black)
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity
            )
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading:
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "arrow.left.circle")
                                .foregroundColor(.yellow)
                            Text("Go Back")
                                .foregroundColor(.yellow)
                        }
                    }
            )
        }
        .navigationBarBackButtonHidden(true)
        .statusBar(hidden: true)
        .onAppear {
            self.presenter.getDetailGenre(id: genreId)
            self.presenter.objectWillChange.send()
        }
    }
}

struct HeaderGenreOverlay: View {
    var name: String?
    var gamesCount: Int?

    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center
        )
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading) {
                Text(name ?? "-")
                    .font(.system(size: 32))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 5)

                Text("Total games: \(gamesCount ?? 0)")
                    .foregroundColor(
                        Color(red: 241 / 255, green: 242 / 255, blue: 246 / 255)
                    )
                    .font(.caption)
            }
            .padding()
        }
    }
}
