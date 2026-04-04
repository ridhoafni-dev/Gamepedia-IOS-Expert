//
//  MockClasses.swift
//  CoreTests
//
//  Created by Testing Framework on 01/04/26.
//

import Combine
import Foundation
import Testing

@testable import Core

// MARK: - Mock Repository

public class MockRepository: Repository {
    public typealias Request = String
    public typealias Response = String

    // Test tracking properties
    public var executeCallCount = 0
    public var executeWithKeywordCallCount = 0
    public var executeWithFavoriteCallCount = 0
    public var lastRequest: String?
    public var lastKeyword: String?
    public var lastId: Int?
    public var lastIsFavorite: Bool?

    // Mock response properties
    public var mockResponse: String = "Mock Response"
    public var mockFavoriteResponse: Bool = true
    public var mockError: Error?

    public init() {}

    public func execute(request: String?) -> AnyPublisher<String, Error> {
        executeCallCount += 1
        lastRequest = request

        if let error = mockError {
            return Fail(error: error).eraseToAnyPublisher()
        }
        return Just(mockResponse)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func execute(request: String?, keyword: String) -> AnyPublisher<String, Error> {
        executeWithKeywordCallCount += 1
        lastRequest = request
        lastKeyword = keyword

        if let error = mockError {
            return Fail(error: error).eraseToAnyPublisher()
        }

        return Just("\(mockResponse) with keyword: \(keyword)")
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    public func execute(request: String?, id: Int, isFavorite: Bool) -> AnyPublisher<Bool, Error> {
        executeWithFavoriteCallCount += 1
        lastRequest = request
        lastId = id
        lastIsFavorite = isFavorite

        if let error = mockError {
            return Fail(error: error).eraseToAnyPublisher()
        }

        return Just(isFavorite)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Helper methods for testing
    public func reset() {
        executeCallCount = 0
        executeWithKeywordCallCount = 0
        executeWithFavoriteCallCount = 0
        lastRequest = nil
        lastKeyword = nil
        lastId = nil
        lastIsFavorite = nil
        mockError = nil
    }
}

// MARK: - Mock DataSource

public class MockDataSource: DataSource {
    public typealias Request = String
    public typealias Response = String

    public var executeCallCount = 0
    public var mockResponse: String = "Mock DataSource Response"
    public var mockError: Error?

    public init() {}

    public func execute(request: String?) -> AnyPublisher<String, Error> {
        executeCallCount += 1
        if let error = mockError { return Fail(error: error).eraseToAnyPublisher() }
        return Just(mockResponse).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    public func execute(request: String?, keyword: String) -> AnyPublisher<String, Error> {
        if let error = mockError { return Fail(error: error).eraseToAnyPublisher() }
        return Just("\(mockResponse) with keyword: \(keyword)").setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    public func execute(request: String?, id: Int, isFavorite: Bool) -> AnyPublisher<String, Error> {
        if let error = mockError { return Fail(error: error).eraseToAnyPublisher() }
        return Just(mockResponse).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}

// MARK: - Mock LocaleDataSource

public class MockLocaleDataSource: LocaleDataSource {
    public typealias Request = String
    public typealias Response = String

    public var listCallCount = 0
    public var getCallCount = 0
    public var addCallCount = 0
    public var addSingleCallCount = 0
    public var updateCallCount = 0
    public var updateFavoriteCallCount = 0
    public var lastUpdateId: Int?
    public var lastUpdateIsFavorite: Bool?

    public var mockListResponse: [String] = ["Mock Item 1", "Mock Item 2"]
    public var mockGetResponse: String = "Mock Get Response"
    public var mockAddResponse: Bool = true
    public var mockUpdateResponse: Bool = true
    public var mockError: Error?

    public init() {}

    public func list(request: String?) -> AnyPublisher<[String], Error> {
        listCallCount += 1
        if let error = mockError { return Fail(error: error).eraseToAnyPublisher() }
        return Just(mockListResponse).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    public func get(id: String) -> AnyPublisher<String, Error> {
        getCallCount += 1
        if let error = mockError { return Fail(error: error).eraseToAnyPublisher() }
        return Just(mockGetResponse).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    public func add(entities: [String]) -> AnyPublisher<Bool, Error> {
        addCallCount += 1
        if let error = mockError { return Fail(error: error).eraseToAnyPublisher() }
        return Just(mockAddResponse).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    public func add(entities: String) -> AnyPublisher<Bool, Error> {
        addSingleCallCount += 1
        if let error = mockError { return Fail(error: error).eraseToAnyPublisher() }
        return Just(mockAddResponse).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    public func update(id: Int, entity: String) -> AnyPublisher<Bool, Error> {
        updateCallCount += 1
        lastUpdateId = id
        if let error = mockError { return Fail(error: error).eraseToAnyPublisher() }
        return Just(mockUpdateResponse).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    public func update(id: Int, isFavorite: Bool) -> AnyPublisher<Bool, Error> {
        updateFavoriteCallCount += 1
        lastUpdateId = id
        lastUpdateIsFavorite = isFavorite
        if let error = mockError { return Fail(error: error).eraseToAnyPublisher() }
        return Just(mockUpdateResponse).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}

// MARK: - Mock Mapper

public struct MockMapper: Mapper {
    public typealias Response = String
    public typealias Entity = String
    public typealias Domain = String

    public var responseToEntityPrefix: String
    public var entityToDomainPrefix: String
    public var responseToDomainPrefix: String

    public init(
        responseToEntityPrefix: String = "Entity_",
        entityToDomainPrefix: String = "Domain_",
        responseToDomainPrefix: String = "DirectDomain_"
    ) {
        self.responseToEntityPrefix = responseToEntityPrefix
        self.entityToDomainPrefix = entityToDomainPrefix
        self.responseToDomainPrefix = responseToDomainPrefix
    }

    public func transformResponseToEntity(response: String) -> String {
        "\(responseToEntityPrefix)\(response)"
    }

    public func transformEntityToDomain(entity: String) -> String {
        "\(entityToDomainPrefix)\(entity)"
    }

    public func transformResponseToDomain(response: String) -> String {
        "\(responseToDomainPrefix)\(response)"
    }
}

// MARK: - Mock Use Case

public struct MockUseCase: UseCase {
    public typealias Request = String
    public typealias Response = String

    public var mockResponse: String
    public var mockError: Error?

    public init(mockResponse: String = "Mock UseCase Response", mockError: Error? = nil) {
        self.mockResponse = mockResponse
        self.mockError = mockError
    }

    public func execute(request: String?) -> AnyPublisher<String, Error> {
        if let error = mockError { return Fail(error: error).eraseToAnyPublisher() }
        return Just(mockResponse).setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    public func execute(request: String?, keyword: String) -> AnyPublisher<String, Error> {
        if let error = mockError { return Fail(error: error).eraseToAnyPublisher() }
        return Just("\(mockResponse) with keyword: \(keyword)").setFailureType(to: Error.self).eraseToAnyPublisher()
    }

    public func execute(request: String?, id: Int, isFavorite: Bool) -> AnyPublisher<Bool, Error> {
        if let error = mockError { return Fail(error: error).eraseToAnyPublisher() }
        return Just(isFavorite).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
}
