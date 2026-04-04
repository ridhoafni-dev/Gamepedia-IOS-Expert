import Combine
import Foundation
import Testing
@testable import Core

// MARK: - Interactor Tests

@Test("Interactor executes repository request successfully")
func testInteractorExecuteSuccess() async throws {
    // Given
    let mockRepository = MockRepository()
    mockRepository.mockResponse = "Success Response"
    let interactor = Interactor(repository: mockRepository)
    let request = "test_request"

    // When
    let result = try await interactor.execute(request: request).firstValue

    // Then
    #expect(result == "Success Response")
    #expect(mockRepository.executeCallCount == 1)
    #expect(mockRepository.lastRequest == request)
}

@Test("Interactor handles repository errors correctly")
func testInteractorExecuteError() async throws {
    // Given
    let mockRepository = MockRepository()
    mockRepository.mockError = TestError.networkError
    let interactor = Interactor(repository: mockRepository)

    // When & Then
    do {
        _ = try await interactor.execute(request: "test").firstValue
        #expect(Bool(false), "Should have thrown an error")
    } catch let error as TestError {
        #expect(error == TestError.networkError)
        #expect(mockRepository.executeCallCount == 1)
    }
}

@Test("Interactor executes with keyword successfully")
func testInteractorExecuteWithKeyword() async throws {
    // Given
    let mockRepository = MockRepository()
    mockRepository.mockResponse = "Search Response"
    let interactor = Interactor(repository: mockRepository)
    let keyword = "search_term"

    // When
    let result = try await interactor.execute(request: nil, keyword: keyword).firstValue

    // Then
    #expect(result == "Search Response with keyword: search_term")
    #expect(mockRepository.executeWithKeywordCallCount == 1)
    #expect(mockRepository.lastKeyword == keyword)
}

@Test("Interactor executes favorite operation successfully")
func testInteractorExecuteWithFavorite() async throws {
    // Given
    let mockRepository = MockRepository()
    let interactor = Interactor(repository: mockRepository)
    let gameId = 123
    let isFavorite = true

    // When
    let result = try await interactor.execute(request: nil, id: gameId, isFavorite: isFavorite).firstValue

    // Then
    #expect(result == true)
    #expect(mockRepository.executeWithFavoriteCallCount == 1)
    #expect(mockRepository.lastId == gameId)
    #expect(mockRepository.lastIsFavorite == isFavorite)
}

@Test("Interactor handles nil request correctly")
func testInteractorExecuteWithNilRequest() async throws {
    // Given
    let mockRepository = MockRepository()
    mockRepository.mockResponse = "Nil Request Response"
    let interactor = Interactor(repository: mockRepository)

    // When
    let result = try await interactor.execute(request: nil).firstValue

    // Then
    #expect(result == "Nil Request Response")
    #expect(mockRepository.executeCallCount == 1)
    #expect(mockRepository.lastRequest == nil)
}

// MARK: - Mapper Tests

@Test("Mapper transforms response to entity correctly")
func testMapperTransformResponseToEntity() {
    // Given
    let mapper = MockMapper(responseToEntityPrefix: "TestEntity_")
    let response = "test_response"

    // When
    let entity = mapper.transformResponseToEntity(response: response)

    // Then
    #expect(entity == "TestEntity_test_response")
}

@Test("Mapper transforms entity to domain correctly")
func testMapperTransformEntityToDomain() {
    // Given
    let mapper = MockMapper(entityToDomainPrefix: "TestDomain_")
    let entity = "test_entity"

    // When
    let domain = mapper.transformEntityToDomain(entity: entity)

    // Then
    #expect(domain == "TestDomain_test_entity")
}

@Test("Mapper transforms response to domain correctly")
func testMapperTransformResponseToDomain() {
    // Given
    let mapper = MockMapper(responseToDomainPrefix: "DirectTestDomain_")
    let response = "test_response"

    // When
    let domain = mapper.transformResponseToDomain(response: response)

    // Then
    #expect(domain == "DirectTestDomain_test_response")
}

@Test("Mapper handles empty strings")
func testMapperHandlesEmptyStrings() {
    // Given
    let mapper = MockMapper()
    let emptyResponse = ""

    // When
    let entity = mapper.transformResponseToEntity(response: emptyResponse)
    let domain = mapper.transformEntityToDomain(entity: entity)
    let directDomain = mapper.transformResponseToDomain(response: emptyResponse)

    // Then
    #expect(entity == "Entity_")
    #expect(domain == "Domain_Entity_")
    #expect(directDomain == "DirectDomain_")
}

// MARK: - Repository Tests (Using Mock)

@Test("Repository executes request successfully")
func testRepositoryExecuteRequest() async throws {
    // Given
    let repository = MockRepository()
    repository.mockResponse = "Repository Success"
    let request = "test_request"

    // When
    let result = try await repository.execute(request: request).firstValue

    // Then
    #expect(result == "Repository Success")
    #expect(repository.executeCallCount == 1)
    #expect(repository.lastRequest == request)
}

@Test("Repository handles network error")
func testRepositoryHandlesNetworkError() async throws {
    // Given
    let repository = MockRepository()
    repository.mockError = TestError.networkError

    // When & Then
    do {
        _ = try await repository.execute(request: "test").firstValue
        #expect(Bool(false), "Should have thrown an error")
    } catch let error as TestError {
        #expect(error == TestError.networkError)
        #expect(repository.executeCallCount == 1)
    }
}

@Test("Repository executes search with keyword")
func testRepositoryExecuteWithKeyword() async throws {
    // Given
    let repository = MockRepository()
    repository.mockResponse = "Search Result"
    let keyword = "game_search"

    // When
    let result = try await repository.execute(request: "search", keyword: keyword).firstValue

    // Then
    #expect(result.contains("game_search"))
    #expect(repository.executeWithKeywordCallCount == 1)
    #expect(repository.lastKeyword == keyword)
}

@Test("Repository handles favorite operation")
func testRepositoryHandlesFavoriteOperation() async throws {
    // Given
    let repository = MockRepository()
    let gameId = 456
    let isFavorite = false

    // When
    let result = try await repository.execute(request: nil, id: gameId, isFavorite: isFavorite).firstValue

    // Then
    #expect(result == false)
    #expect(repository.executeWithFavoriteCallCount == 1)
    #expect(repository.lastId == gameId)
    #expect(repository.lastIsFavorite == isFavorite)
}

// MARK: - DataSource Tests

@Test("DataSource executes successfully")
func testDataSourceExecuteSuccess() async throws {
    // Given
    let dataSource = MockDataSource()
    dataSource.mockResponse = "DataSource Success"

    // When
    let result = try await dataSource.execute(request: "test").firstValue

    // Then
    #expect(result == "DataSource Success")
    #expect(dataSource.executeCallCount == 1)
}

@Test("DataSource handles error")
func testDataSourceHandlesError() async throws {
    // Given
    let dataSource = MockDataSource()
    dataSource.mockError = TestError.parsingError

    // When & Then
    do {
        _ = try await dataSource.execute(request: "test").firstValue
        #expect(Bool(false), "Should have thrown an error")
    } catch let error as TestError {
        #expect(error == TestError.parsingError)
    }
}

// MARK: - LocaleDataSource Tests

@Test("LocaleDataSource lists items successfully")
func testLocaleDataSourceList() async throws {
    // Given
    let dataSource = MockLocaleDataSource()
    dataSource.mockListResponse = ["Item1", "Item2", "Item3"]

    // When
    let result = try await dataSource.list(request: nil).firstValue

    // Then
    #expect(result.count == 3)
    #expect(result.contains("Item1"))
    #expect(result.contains("Item2"))
    #expect(result.contains("Item3"))
    #expect(dataSource.listCallCount == 1)
}

@Test("LocaleDataSource gets item by id")
func testLocaleDataSourceGet() async throws {
    // Given
    let dataSource = MockLocaleDataSource()
    dataSource.mockGetResponse = "Retrieved Item"
    let itemId = "test_id"

    // When
    let result = try await dataSource.get(id: itemId).firstValue

    // Then
    #expect(result == "Retrieved Item")
    #expect(dataSource.getCallCount == 1)
}

@Test("LocaleDataSource adds items successfully")
func testLocaleDataSourceAdd() async throws {
    // Given
    let dataSource = MockLocaleDataSource()
    let newItems = ["New Item 1", "New Item 2"]

    // When
    let result = try await dataSource.add(entities: newItems).firstValue

    // Then
    #expect(result == true)
    #expect(dataSource.addCallCount == 1)
}

@Test("LocaleDataSource adds single entity successfully")
func testLocaleDataSourceAddSingle() async throws {
    // Given
    let dataSource = MockLocaleDataSource()
    let newItem = "Single New Item"

    // When
    let result = try await dataSource.add(entities: newItem).firstValue

    // Then
    #expect(result == true)
    #expect(dataSource.addSingleCallCount == 1)
}

@Test("LocaleDataSource updates item by Int id successfully")
func testLocaleDataSourceUpdate() async throws {
    // Given
    let dataSource = MockLocaleDataSource()
    let itemId = 42
    let updatedItem = "Updated Item"

    // When
    let result = try await dataSource.update(id: itemId, entity: updatedItem).firstValue

    // Then
    #expect(result == true)
    #expect(dataSource.updateCallCount == 1)
    #expect(dataSource.lastUpdateId == itemId)
}

@Test("LocaleDataSource updates isFavorite status successfully")
func testLocaleDataSourceUpdateFavorite() async throws {
    // Given
    let dataSource = MockLocaleDataSource()
    let itemId = 99
    let isFavorite = true

    // When
    let result = try await dataSource.update(id: itemId, isFavorite: isFavorite).firstValue

    // Then
    #expect(result == true)
    #expect(dataSource.updateFavoriteCallCount == 1)
    #expect(dataSource.lastUpdateId == itemId)
    #expect(dataSource.lastUpdateIsFavorite == isFavorite)
}

// MARK: - UseCase Tests

@Test("UseCase executes successfully")
func testUseCaseExecuteSuccess() async throws {
    // Given
    let useCase = MockUseCase(mockResponse: "UseCase Success")

    // When
    let result = try await useCase.execute(request: "test").firstValue

    // Then
    #expect(result == "UseCase Success")
}

@Test("UseCase handles error")
func testUseCaseHandlesError() async throws {
    // Given
    let useCase = MockUseCase(mockError: TestError.unauthorized)

    // When & Then
    do {
        _ = try await useCase.execute(request: "test").firstValue
        #expect(Bool(false), "Should have thrown an error")
    } catch let error as TestError {
        #expect(error == TestError.unauthorized)
    }
}
