//
//  TestUtilities.swift
//  CoreTests
//
//  Created by Testing Framework on 01/04/26.
//

import Testing
import Combine
import Foundation
@testable import Core

// MARK: - Test Utilities and Extensions

/// Helper extension for AnyPublisher to get first value for testing
extension AnyPublisher where Output: Sendable {
    var firstValue: Output {
        get async throws {
            return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Output, Error>) in
                nonisolated(unsafe) var cancellable: AnyCancellable?
                cancellable = self.sink(
                    receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            break
                        case .failure(let error):
                            continuation.resume(throwing: error)
                        }
                        cancellable?.cancel()
                    },
                    receiveValue: { value in
                        continuation.resume(returning: value)
                        cancellable?.cancel()
                    }
                )
            }
        }
    }
}

/// Helper extension for testing async publishers
extension AnyPublisher where Failure == Error {
    func collectFirst() -> AnyPublisher<Output, Failure> {
        return self.prefix(1).eraseToAnyPublisher()
    }
}

// MARK: - Test Errors

enum TestError: Error, Equatable {
    case networkError
    case parsingError
    case notFound
    case unauthorized
    
    var localizedDescription: String {
        switch self {
        case .networkError:
            return "Network error occurred"
        case .parsingError:
            return "Failed to parse data"
        case .notFound:
            return "Resource not found"
        case .unauthorized:
            return "Unauthorized access"
        }
    }
}

// MARK: - Test Data Factory

class TestDataFactory {
    static func createTestString(_ suffix: String = "") -> String {
        return "TestData\(suffix.isEmpty ? "" : "_\(suffix)")"
    }
    
    static func createTestArray<T>(_ element: T, count: Int = 3) -> [T] {
        return Array(repeating: element, count: count)
    }
    
    static func createTestDictionary() -> [String: Any] {
        return [
            "id": 1,
            "name": "Test Name",
            "value": "Test Value",
            "isActive": true
        ]
    }
}
