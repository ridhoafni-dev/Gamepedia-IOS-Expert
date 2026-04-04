//
//  GetFavoritiesRepository.swift
//  Favorite
//
//  Created by User on 28/02/26.
//

import Combine
import Core
import Games

public struct GetFavoritiesRepository<
    FavoriteLocaleDataSource: LocaleDataSource,
    Transformer: Mapper
>: Repository
where
    FavoriteLocaleDataSource.Response == GameModuleEntity,
    Transformer.Response == Bool,
    Transformer.Entity == [GameModuleEntity],
    Transformer.Domain == [DetailGameDomainModel]
{

    public typealias Request = Any
    public typealias Response = [DetailGameDomainModel]

    private let _localeDataSource: FavoriteLocaleDataSource
    private let _mapper: Transformer

    public init(
        localeDataSource: FavoriteLocaleDataSource,
        mapper: Transformer
    ) {
        _localeDataSource = localeDataSource
        _mapper = mapper
    }

    public func execute(request: Any?) -> AnyPublisher<[DetailGameDomainModel], Error> {
        return _localeDataSource.list(request: nil)
            .map {
                _mapper.transformEntityToDomain(entity: $0)
            }.eraseToAnyPublisher()
    }

    public func execute(request: Request?, id: Int, isFavorite: Bool) -> AnyPublisher<Bool, Error> {
        return _localeDataSource.update(id: id, isFavorite: isFavorite)
    }

    public func execute(request: Request?, keyword: String) -> AnyPublisher<[DetailGameDomainModel], Error> {
        fatalError()
    }

    public func execute(request: Request?, id: Int, isFavorite: Bool) -> AnyPublisher<[DetailGameDomainModel], Error> {
        fatalError()
    }

}
