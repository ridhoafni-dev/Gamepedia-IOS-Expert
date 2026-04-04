//
//  DeveloperResponse.swift
//  Developer
//
//  Created by User on 08/02/26.
//

import Foundation
nonisolated
public struct DeveloperResponse: Decodable, Sendable {
    public let count: Int?
    public let next, previous: String?
    public let results: [DeveloperResult]?
}

public struct GameInDeveloper: Decodable, Sendable {
    public let id: Int?
    public let name, slug: String?
    public let added: Int?
}

nonisolated
public struct DeveloperResult: Decodable, Sendable {
    public let id: Int?
    public let name, slug: String?
    public let gamesCount: Int?
    public let imageBackground: String?
    public let games: [GameInDeveloper]?

    enum CodingKeys: String, CodingKey {
        case id, name, slug, gamesCount = "games_count", imageBackground = "image_background", games
    }
}
