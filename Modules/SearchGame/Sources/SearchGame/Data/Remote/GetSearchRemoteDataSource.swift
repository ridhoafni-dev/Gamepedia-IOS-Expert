//
//  GetSearchRemoteDataSource.swift
//  SearchGame
//
//  Created by User on 26/02/26.
//

import Alamofire
import Combine
import Core
import Foundation

public struct GetSearchRemoteDataSource: DataSource, Sendable {
    let apiKey = "57c0b6e9af804675b9d7e47496de41de"  //Bundle.main.infoDictionary?["API_KEY"] as! String

    public typealias Request = Any
    public typealias Response = [SearchResult]

    private let _endpoint: String

    public init(endpoint: String) {
        self._endpoint = endpoint
    }

    public func execute(request: Any?, keyword: String) -> AnyPublisher<
        [SearchResult], Error
    > {
        let param = ["key": apiKey, "search": keyword]

        return Future<[SearchResult], Error> { @Sendable completion in
            if let url = URL(string: self._endpoint) {
                AF.request(
                    url,
                    method: .get,
                    parameters: param
                )
                .validate()
                .responseDecodable(of: SearchResponse.self) { response in
                    switch response.result {
                    case .failure:
                        completion(.failure(URLError.invalidResponse))
                    case .success(let value):
                        completion(.success(value.results ?? []))
                    }
                }
            }
        }.eraseToAnyPublisher()
    }

    public func execute(request: Request?) -> AnyPublisher<
        [SearchResult], Error
    > {
        fatalError()
    }

    public func execute(request: Request?, id: Int, isFavorite: Bool)
        -> AnyPublisher<[SearchResult], Error>
    {
        fatalError()
    }

}
