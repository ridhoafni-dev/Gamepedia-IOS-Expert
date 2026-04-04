//
//  GetGenresRemoteDataSource.swift
//  Genres
//
//  Created by User on 22/02/26.
//


import Alamofire
import Combine
import Core
import Foundation
public struct GetGenresRemoteDataSource {
    let apiKey = "57c0b6e9af804675b9d7e47496de41de" //Bundle.main.infoDictionary?["API_KEY"] as! String
    let orderByRatingAsc = "rating"
    let orderByRatingDesc = "-rating"
    let page = "1"

    public init() {}

    func getListGenres() -> AnyPublisher<[GenreResult], Error> {
        return Future<[GenreResult], Error> { completion in
            if let url = URL(string: "https://api.rawg.io/api/genres") {
                AF.request(url, method: .get, parameters: ["key": apiKey])
                    .validate()
                    .responseDecodable(of: GenreResponse.self) { @Sendable response in
                        switch response.result {
                        case .success(let data):
                            completion(.success(data.results ?? []))
                        case .failure:
                            completion(.failure(URLError.invalidResponse))
                        }
                    }
            } else {
                completion(.failure(URLError.invalidResponse))
            }
        }
        .eraseToAnyPublisher()
    }

    func getGenreDetails(id: Int) -> AnyPublisher<DetailGenreResponse, Error> {
        return Future<DetailGenreResponse, Error> { completion in
          if let url = URL(string: "https://api.rawg.io/api/genres/\(id)") {
            AF.request(
              url,
              method: .get,
              parameters: ["key": apiKey]
            )
            .validate()
            .responseDecodable(of: DetailGenreResponse.self) { response in
              switch response.result {
              case .success(let value):
                completion(.success(value))
              case .failure:
                completion(.failure(URLError.invalidResponse))
              }
            }
          }
        }.eraseToAnyPublisher()
      }
}
