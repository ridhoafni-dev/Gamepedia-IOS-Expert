//
//  SearchResponse.swift
//  SearchGame
//
//  Created by User on 26/02/26.
//


import Foundation
public struct SearchResponse: Decodable, Sendable {
    public var count: Int?
    public var next, previous: String?
    public var results: [SearchResult]?

    public init(
        count: Int? = nil,
        next: String? = nil,
        previous: String? = nil,
        results: [SearchResult]? = nil
    ) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
}

public struct SearchResult: Decodable, Sendable {
    public var id: Int?
    public var name, slug: String?
    public var playtime: Int?
    public var released: String?
    public var rating: Double?
    public var score: String?
    public var backgroundImage: String?

    public init(
        id: Int? = nil,
        name: String? = nil,
        slug: String? = nil,
        playtime: Int? = nil,
        released: String? = nil,
        rating: Double? = nil,
        score: String? = nil,
        backgroundImage: String? = nil
    ) {
        self.id = id
        self.name = name
        self.slug = slug
        self.playtime = playtime
        self.released = released
        self.rating = rating
        self.score = score
        self.backgroundImage = backgroundImage
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case playtime
        case released
        case rating
        case score
        case backgroundImage = "background_image"
    }
}
