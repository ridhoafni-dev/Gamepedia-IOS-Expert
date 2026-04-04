//
//  GetGamesRemoteDataSource.swift
//  Game
//
//  Created by User on 31/01/26.
//


import Alamofire
import Combine
import Core
import Foundation
public struct GetGamesRemoteDataSource {
    let apiKey = "57c0b6e9af804675b9d7e47496de41de" //Bundle.main.infoDictionary?["API_KEY"] as! String
    let orderByRatingAsc = "rating"
    let orderByRatingDesc = "-rating"
    let page = "1"

    public init(){}

    func getDiscoveryGames(sortFromBest: Bool) -> AnyPublisher<[GameResult], Error> {
        let param = ["key": apiKey, "ordering": sortFromBest == true ? orderByRatingDesc: orderByRatingAsc]

        return Future<[GameResult], Error> { @Sendable completion in
            if let url = URL(string: Endpoints.Gets.games.url) {
                AF.request(
                  url,
                  method: .get,
                  parameters: param
                )
                .validate()
                .responseDecodable(of: GameResponse.self) { response in
                  switch response.result {
                  case .success(let value):
                    completion(.success(value.results!))
                  case .failure:
                    completion(.failure(URLError.invalidResponse))
                  }
                }
              }
            }.eraseToAnyPublisher()
    }

    func getFewDiscoveryGames() -> AnyPublisher<[GameResult], Error> {
        let param = ["key": apiKey, "ordering": orderByRatingDesc, "page_size": "10"]

        return Future<[GameResult], Error> { @Sendable completion in
            if let url = URL(string: Endpoints.Gets.games.url) {
                AF.request(url, method: .get, parameters: param)
                    .validate()
                    .responseDecodable(of: GameResponse.self) { response in
                        switch response.result {
                        case .success(let data):
                            completion(.success(data.results!))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }

    func getGameDetails(id: Int) -> AnyPublisher<DetailGameResponse, Error> {
        let param = ["key": apiKey]

        return Future<DetailGameResponse, Error> { @Sendable completion in
            if let url = URL(string: "\(Endpoints.Gets.games.url)/\(id)") {
                AF.request(url, method: .get, parameters: param)
                    .validate()
                    .responseDecodable(of: DetailGameResponse.self) { response in
                        switch response.result {
                        case .success(let data):
                            completion(.success(data))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }


}
