//
//  DeveloperDomainModel.swift
//  Developer
//
//  Created by User on 08/02/26.
//


import Foundation
public struct DeveloperDomainModel: Equatable, Identifiable {
    public let id: Int?
    public let name, slug: String?
    public let gamesCount: Int?
    public let imageBackground: String?
    public let games: [GameInDeveloperDomainModel]

    public init(
        id: Int?,
        name: String?,
        slug: String?,
        gamesCount: Int?,
        imageBackground: String?,
        games: [GameInDeveloperDomainModel]
    ) {
        self.id = id
        self.name = name
        self.slug = slug
        self.gamesCount = gamesCount
        self.imageBackground = imageBackground
        self.games = games
    }
}

public struct GameInDeveloperDomainModel: Equatable, Identifiable {
    public let id: Int?
    public let name, slug: String?
    public let added: Int?

    public init(
        id: Int?,
        name: String?,
        slug: String?,
        added: Int?
    ) {
        self.id = id
        self.name = name
        self.slug = slug
        self.added = added
    }
}
