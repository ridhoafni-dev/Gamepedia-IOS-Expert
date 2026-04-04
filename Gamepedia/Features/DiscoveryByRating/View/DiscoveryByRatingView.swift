//
//  DiscoveryByRatingView.swift
//  Gamepedia
//
//  Created by User on 04/01/26.
//

import SwiftUI
import Combine
import Games
import Favorite
import Genres
import Core

struct DiscoveryByRatingView: View {
    @ObservedObject var presenter: GamePresenter
    @ObservedObject var favoritePresenter: FavoritePresenterType
    
    private var placeholder: String? = "Sort Game by Rating"
    private var onOptionSelected: ((_ _option: GenreFilterDropdownOptionDomainModel) -> Void)? = { option in
        print("Option selected: \(option)")
    }

    var body: some View {
        DiscoveryContent(
            presenter: presenter,
            favoritePresenter: favoritePresenter
        )
    }

    init(presenter: GamePresenter, favoritePresenter: FavoritePresenterType) {
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.backgroundColor = UIColor.black

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance

        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .black
        UITableView.appearance().tableFooterView = UIView()

        self.presenter = presenter
        self.favoritePresenter = favoritePresenter
    }
}

struct DiscoveryContent: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var presenter: GamePresenter
    @ObservedObject var favoritePresenter: FavoritePresenterType
    
    init(presenter: GamePresenter, favoritePresenter: FavoritePresenterType) {
        self.presenter = presenter
        self.favoritePresenter = favoritePresenter
    }

    
    @State private var shouldShowDropdown = false
    @State private var selectedOption: GenreFilterDropdownOptionDomainModel? = nil
    
    let options: [GenreFilterDropdownOptionDomainModel] = [
        GenreFilterDropdownOptionDomainModel(key: "1", value: "Best Rated"),
        GenreFilterDropdownOptionDomainModel(key: "2", value: "Worst Rated")
    ]
    
    var onOptionSelected: ((_ _option: GenreFilterDropdownOptionDomainModel) -> Void)?
    
    private var buttonHeight: CGFloat = 35
    
    var body: some View {
        let router = DiscoveryByRatingRouter(presenter: presenter, favoritePresenter: favoritePresenter)
        
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    DropdownSection(
                        shouldShowDropdown: $shouldShowDropdown,
                        selectedOption: $selectedOption,
                        options: options,
                        presenter: presenter
                    )
                    
                    GameListSection(presenter: presenter, router: router)
                }
                .navigationBarTitle("Discovery Game")
                .padding(.bottom, 50)
                .padding(.horizontal, 10)
            }
            .background(Color.black)
            .navigationBarItems(leading: BackButton {
                presentationMode.wrappedValue.dismiss()
            })
        }
        .navigationBarBackButtonHidden(true)
        .statusBar(hidden: true)
        .onAppear {
            setupInitialState()
        }
    }
    
    private func setupInitialState() {
        selectedOption = options.first
        presenter.games = []
        
        let statusFilter = selectedOption?.value == options[0].value
        presenter.getGamesFromBest(isBest: statusFilter)
        presenter.objectWillChange.send()
    }
}

struct DropdownSection: View {
    @Binding var shouldShowDropdown: Bool
    @Binding var selectedOption: GenreFilterDropdownOptionDomainModel?
    let options: [GenreFilterDropdownOptionDomainModel]
    let presenter: GamePresenter
    
    var body: some View {
        VStack {
            DropdownButton(
                shouldShowDropdown: $shouldShowDropdown,
                selectedOption: selectedOption
            )
            .overlay(
                DropdownOverlay(
                    shouldShowDropdown: shouldShowDropdown,
                    options: options,
                    onOptionSelected: { option in
                        shouldShowDropdown = false
                        selectedOption = option
                        
                        presenter.games = []
                        let statusFilter = selectedOption?.value == options[0].value
                        presenter.getGamesFromBest(isBest: statusFilter)
                    }
                )
            )
        }
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(red: 67/255, green: 67/255, blue: 67/255))
        )
        .padding(.horizontal, 20)
    }
}

struct DropdownButton: View {
    @Binding var shouldShowDropdown: Bool
    let selectedOption: GenreFilterDropdownOptionDomainModel?
    
    var body: some View {
        Button(action: {
            shouldShowDropdown.toggle()
        }) {
            HStack {
                Text(selectedOption?.value ?? "Sort")
                    .font(.system(size: 14))
                    .foregroundColor(selectedOption == nil ? .white : .yellow)
                    .fontWeight(.bold)
                
                Spacer()
                
                Image(systemName: shouldShowDropdown ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                    .resizable()
                    .frame(width: 9, height: 5)
                    .font(.system(size: 9, weight: .medium))
                    .foregroundColor(.yellow)
            }
            .padding(.horizontal)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .frame(height: 35)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.yellow, lineWidth: 3)
            )
        }
    }
}

struct DropdownOverlay: View {
    let shouldShowDropdown: Bool
    let options: [GenreFilterDropdownOptionDomainModel]
    let onOptionSelected: (GenreFilterDropdownOptionDomainModel) -> Void
    
    var body: some View {
        VStack {
            if shouldShowDropdown {
                Spacer(minLength: 45)
                Dropdown(
                    options: options,
                    onOptionSelected: onOptionSelected
                )
            }
        }
    }
}

struct GameListSection: View {
    @ObservedObject var presenter: GamePresenter
    let router: DiscoveryByRatingRouter

    var body: some View {
        if presenter.loadingState {
            LoadingView()
        }else {
            if (!presenter.games.isEmpty) {
                LazyVStack {
                    ForEach(presenter.gamesByRating, id: \.id) { game in
                        NavigationLink(
                          destination: router.makeDetailView(for: game.id ?? 0)
                        ) {
                          GameRatingItem(presenter: presenter, game: game)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
                .padding(.top, 10)
                .zIndex(-1)
            } else {
                VStack(alignment: .center) {
                    Text("No result found...")
                }.frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .center
                )
            }
        }
    }
}

struct LoadingView: View {
    var body: some View {
        ZStack {
            ProgressView()
        }
        .frame(
            minWidth: 200,
            maxWidth: .infinity,
            minHeight: 230,
            maxHeight: .infinity,
            alignment: .center
        )
    }
}

struct BackButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "arrow.left.circle")
                    .foregroundColor(.yellow)
                Text("Go Back")
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct Dropdown: View {
    var options: [GenreFilterDropdownOptionDomainModel]
    var onOptionSelected: (GenreFilterDropdownOptionDomainModel) -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ForEach(options, id: \.self) { option in
                    DropdownRow(option: option, onOptionSelected: onOptionSelected)
                        .zIndex(1)
                }
            }
        }
        .frame(height: 60)
        .padding(.vertical, 5)
        .background(Color(red: 67/255, green: 67/255, blue: 67/255))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(.yellow, lineWidth: 3)
        )
        .zIndex(1)
    }
}

struct DropdownRow: View {
    var option: GenreFilterDropdownOptionDomainModel
    var onOptionSelected: (GenreFilterDropdownOptionDomainModel) -> Void
    
    var body: some View {
        Button(action: {
            onOptionSelected(option)
        }) {
            HStack {
                Text(option.value)
                    .font(.system(size: 14))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                Spacer()
            }
            .frame(height: 30)
            .background(Color.clear)
        }
    }
}
