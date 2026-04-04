//
//  GenreDomainModule.swift
//  Genres
//
//  Created by User on 25/02/26.
//

import Foundation

public struct GenreDomainModel: Equatable, Identifiable {
    public let id: Int?
    public let name, slug: String?
    public let gamesCount: Int?
    public let imageBackground: String?
    public var desc: String = "Unknown Description"
    public let games: [GameInGenreModel]
}

public struct GameInGenreModel: Equatable, Identifiable {
    public let id: Int?
    public let name, slug: String?
    public let added: Int?
}
