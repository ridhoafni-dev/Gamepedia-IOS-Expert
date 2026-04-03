//
//  GenreFilterDropdownOptionDomainModel.swift
//  Game
//
//  Created by User on 05/02/26.
//

public struct GenreFilterDropdownOptionDomainModel: Hashable {
    public let key: String
    public let value: String
    
    public init(key: String, value: String) {
        self.key = key
        self.value = value
    }
    
    public static func == (lhs: GenreFilterDropdownOptionDomainModel, rhs: GenreFilterDropdownOptionDomainModel) -> Bool {
        return lhs.key == rhs.key
    }
}
