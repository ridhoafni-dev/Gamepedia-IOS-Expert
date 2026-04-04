//
//  SearchDomainModek.swift
//  SearchGame
//
//  Created by User on 27/02/26.
//

import Foundation

public struct SearchDomainModel: Equatable, Identifiable {
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
}
