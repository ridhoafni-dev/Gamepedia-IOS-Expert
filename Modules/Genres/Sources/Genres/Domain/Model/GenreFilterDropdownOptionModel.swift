//
//  GenreFilterDropdownOptionModel.swift
//  Genres
//
//  Created by User on 25/02/26.
//

public struct GenreFilterDropdownOptionModel: Hashable {
    public let key: String
    public let value: String

    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }

    public static func == (lhs: GenreFilterDropdownOptionModel, rhs: GenreFilterDropdownOptionModel) -> Bool {
        return lhs.key == rhs.key
    }
}
