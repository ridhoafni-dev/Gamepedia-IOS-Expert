//
//  GenreGridView.swift
//  Gamepedia
//
//  Created by User on 16/01/26.
//

import SwiftUI
import Genres
import Games
import Core

struct GenreGridView: View {
    @ObservedObject var presenter: GenrePresenter
    var router: HomeRouter
    
    var body: some View {
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(presenter.genres) { genre in
                    ZStack {
                        NavigationLink(
                            destination: router.makeDetailGenreView(for: genre.id ?? 0)
                        ) {
                            GenreItem(genre: genre)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}
