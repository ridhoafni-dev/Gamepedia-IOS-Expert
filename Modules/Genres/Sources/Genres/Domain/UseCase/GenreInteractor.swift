//
//  GenreInteractor.swift
//  Genres
//
//  Created by User on 25/02/26.
//


import Foundation
import Combine

public protocol GenreUseCase {
  func getListGenres() -> AnyPublisher<[GenreDomainModel], Error>
  func getDetailGenre(id: Int) -> AnyPublisher<GenreDomainModel, Error>
}

public class GenreInteractor: GenreUseCase {
  private let repository: GetGenresRepository
  
  public init(repository: GetGenresRepository) {
    self.repository = repository
  }
  
  public func getListGenres() -> AnyPublisher<[GenreDomainModel], Error> {
    return repository.getListGenres()
  }

  public func getDetailGenre(id: Int) -> AnyPublisher<GenreDomainModel, Error> {
    return repository.getGenreDetail(id: id)
  }

}

