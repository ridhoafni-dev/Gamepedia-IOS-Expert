//
//  UseCase.swift
//  Core
//
//  Created by User on 27/01/26.
//
import Combine
import Foundation
public protocol UseCase {
    associatedtype Request
    associatedtype Response

    func execute(request: Request?) -> AnyPublisher<Response, Error>
    func execute(request: Request?, keyword: String) -> AnyPublisher<Response, Error>
    func execute(request: Request?, id: Int, isFavorite: Bool) -> AnyPublisher<Bool, Error>
}
