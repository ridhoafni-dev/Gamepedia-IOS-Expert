//
//  DetailContent.swift
//  Gamepedia
//
//  Created by User on 10/01/26.
//

import Combine
import Core
import Favorite
import Games
import SwiftUI

struct DetailContent: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var presenter: GamePresenter
    @ObservedObject var favoritePresenter: DetailFavoritePresenterType

    @State var isFavorite: Bool = false
    @State var gameId: Int
    @State var isAdd: Bool
    @State var isUpdateFavorite: Bool = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                TopSection(presenter: presenter)
                Divider()
                BottomSection(presenter: presenter)
            }
            .padding(.bottom, 50)
        }
        .background(Color.black)
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .navigationBarItems(
            leading: Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack {
                    Image(systemName: "arrow.left.circle")
                        .foregroundColor(.yellow)
                    Text("Go Back")
                        .foregroundColor(.yellow)
                }
            }
        )
        .navigationBarItems(
            trailing: Button(action: {
                isFavorite = !isFavorite
                if let gameId = presenter.detailGame?.id {
                    favoritePresenter.updateFavorite(
                        request: nil,
                        id: gameId,
                        isFavorite: isFavorite
                    )
                    isUpdateFavorite = true
                }
            }) {
                Image(
                    systemName: isFavorite
                        ? "heart.circle.fill" : "heart.circle"
                )
                .foregroundColor(isFavorite ? .red : .gray)
            }
        )
        .navigationBarBackButtonHidden(true)
        //.phoneOnlyStackNavigationView()
        .statusBar(hidden: true)
        .onAppear {
            self.presenter.getDetailGame(id: gameId, isAdd: isAdd)
            //self.presenter.objectWillChange.send()
            isFavorite = presenter.detailGame?.isFavorite ?? false
        }
        .onChange(of: presenter.detailGame?.isFavorite) { newValue in
            guard let newValue = newValue else { return }
            isFavorite = newValue
        }
    }
}
