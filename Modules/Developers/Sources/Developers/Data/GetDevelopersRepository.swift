//
//  GetDeveloperRepository.swift
//  Developer
//
//  Created by User on 08/02/26.
//

import Combine
import Core
import Foundation

public struct GetDevelopersRepository<
    LocaleDS: LocaleDataSource,
    RemoteDS: DataSource,
    Transformer: Mapper
>: Repository
where
    LocaleDS.Response == DeveloperModuleEntity,
    RemoteDS.Response == [DeveloperResult],
    Transformer.Response == [DeveloperResult],
    Transformer.Entity == [DeveloperModuleEntity],
    Transformer.Domain == [DeveloperDomainModel]
{

    public typealias Request = Any
    public typealias Response = [DeveloperDomainModel]

    private let _localeDataSource: LocaleDS
    private let _remoteDataSource: RemoteDS
    private let _mapper: Transformer

    public init(
        localeDataSource: LocaleDS,
        remoteDataSource: RemoteDS,
        mapper: Transformer
    ) {
        _localeDataSource = localeDataSource
        _remoteDataSource = remoteDataSource
        _mapper = mapper
    }

    public func execute(request: Any?) -> AnyPublisher<
        [DeveloperDomainModel], Error
    > {
        return _localeDataSource.list(request: nil)
            .flatMap { result -> AnyPublisher<[DeveloperDomainModel], Error> in
                if result.isEmpty {
                    return _remoteDataSource.execute(request: nil)
                        .map { _mapper.transformResponseToEntity(response: $0) }
                        .catch { _ in _localeDataSource.list(request: nil) }
                        .flatMap { _localeDataSource.add(entities: $0) }
                        .filter { $0 }
                        .flatMap { _ in
                            _localeDataSource.list(request: nil)
                                .map {
                                    _mapper.transformEntityToDomain(entity: $0)
                                }
                        }
                        .eraseToAnyPublisher()
                } else {
                    return _localeDataSource.list(request: nil)
                        .map { _mapper.transformEntityToDomain(entity: $0) }
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }

    public func execute(request: Request?, keyword: String) -> AnyPublisher<
        Response, Error
    > {
        fatalError()
    }

    public func execute(request: Request?, id: Int, isFavorite: Bool)
        -> AnyPublisher<Bool, Error>
    {
        fatalError()
    }
}
