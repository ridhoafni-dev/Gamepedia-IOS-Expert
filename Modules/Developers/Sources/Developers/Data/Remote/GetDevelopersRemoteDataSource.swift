//
//  GetDevelopersRemoteDataSource.swift
//  Developer
//
//  Created by User on 08/02/26.
//

import Alamofire
import Combine
import Core
import Foundation

public struct GetDevelopersRemoteDataSource: DataSource {
    let apiKey = "57c0b6e9af804675b9d7e47496de41de"

    public typealias Request = Any
    public typealias Response = [DeveloperResult]

    private let _endpoint: String

    public init(endpoint: String) {
        self._endpoint = endpoint
    }

    // Required by DataSource: execute(request:)
    // swiftlint:disable:next type_body_length
    public func execute(request: Request?) -> AnyPublisher<Response, Error> {
        let param = ["key": apiKey]
        let endpoint = _endpoint
        return Future<Response, Error> { completion in
            if let url = URL(string: endpoint) {
                AF.request(
                    url,
                    method: .get,
                    parameters: param,
                    encoding: URLEncoding.default,
                    headers: nil
                )
                .validate()
                .responseDecodable(of: DeveloperResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value.results ?? []))
                    case .failure:
                        completion(.failure(URLError(.badServerResponse)))
                    }
                }
            } else {
                completion(.failure(URLError(.badURL)))
            }
        }
        .eraseToAnyPublisher()
    }

    // Required by DataSource: execute(request:keyword:)
    public func execute(request: Request?, keyword: String) -> AnyPublisher<
        Response, Error
    > {
        let param: [String: String] = ["key": apiKey, "search": keyword]
        let endpoint = _endpoint
        return Future<Response, Error> { completion in
            if let url = URL(string: endpoint) {
                AF.request(
                    url,
                    method: .get,
                    parameters: param,
                    encoding: URLEncoding.default,
                    headers: nil
                )
                .validate()
                .responseDecodable(of: DeveloperResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value.results ?? []))
                    case .failure:
                        completion(.failure(URLError(.badServerResponse)))
                    }
                }
            } else {
                completion(.failure(URLError(.badURL)))
            }
        }
        .eraseToAnyPublisher()
    }

    // Required by DataSource: execute(request:id:isFavorite:)
    // Not applicable for remote developers list; return a Fail publisher to satisfy protocol.
    public func execute(request: Request?, id: Int, isFavorite: Bool)
        -> AnyPublisher<Response, Error>
    {
        Fail(error: URLError(.unsupportedURL)).eraseToAnyPublisher()
    }
}
