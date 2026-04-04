//
//  LocaleDataSource.swift
//  Core
//
//  Created by User on 27/01/26.
//
import Combine
import Foundation
public protocol LocaleDataSource {
    associatedtype Request
    associatedtype Response

    func list(request: Request?) -> AnyPublisher<[Response], Error>
    func add(entities: [Response]) -> AnyPublisher<Bool, Error>
    func add(entities: Response) -> AnyPublisher<Bool, Error>
    func get(id: String) -> AnyPublisher<Response, Error>
    func update(id: Int, entity: Response) -> AnyPublisher<Bool, Error>
    func update(id: Int, isFavorite: Bool) -> AnyPublisher<Bool, Error>
}
