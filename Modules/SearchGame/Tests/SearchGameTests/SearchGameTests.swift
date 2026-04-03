import Testing
import Foundation
@testable import SearchGame

// MARK: - Test Data Helpers

private func makeSearchResult(
    id: Int = 1,
    name: String = "Test Game",
    slug: String = "test-game",
    playtime: Int = 10,
    released: String = "2024-01-01",
    rating: Double = 4.0,
    score: String = "exceptional",
    backgroundImage: String = "https://example.com/bg.jpg"
) -> SearchResult {
    return SearchResult(
        id: id,
        name: name,
        slug: slug,
        playtime: playtime,
        released: released,
        rating: rating,
        score: score,
        backgroundImage: backgroundImage
    )
}

// MARK: - SearchTransformer: Response to Domain

@Test("SearchTransformer maps single search result to domain correctly")
func testTransformResponseToDomain_singleItem() {
    let transformer = SearchTransformer()
    let result = makeSearchResult(
        id: 5,
        name: "Cyberpunk 2077",
        slug: "cyberpunk-2077",
        playtime: 50,
        released: "2020-12-10",
        rating: 3.9,
        score: "meh",
        backgroundImage: "https://example.com/cyberpunk.jpg"
    )
    
    let domains = transformer.transformResponseToDomain(response: [result])
    
    #expect(domains.count == 1)
    let domain = domains[0]
    #expect(domain.id == 5)
    #expect(domain.name == "Cyberpunk 2077")
    #expect(domain.slug == "cyberpunk-2077")
    #expect(domain.playtime == 50)
    #expect(domain.released == "2020-12-10")
    #expect(domain.rating == 3.9)
    #expect(domain.score == "meh")
    #expect(domain.backgroundImage == "https://example.com/cyberpunk.jpg")
}

@Test("SearchTransformer maps multiple search results to domains")
func testTransformResponseToDomain_multipleItems() {
    let transformer = SearchTransformer()
    let results = [
        makeSearchResult(id: 1, name: "Game A"),
        makeSearchResult(id: 2, name: "Game B"),
        makeSearchResult(id: 3, name: "Game C")
    ]
    
    let domains = transformer.transformResponseToDomain(response: results)
    
    #expect(domains.count == 3)
    #expect(domains[0].id == 1)
    #expect(domains[0].name == "Game A")
    #expect(domains[1].id == 2)
    #expect(domains[1].name == "Game B")
    #expect(domains[2].id == 3)
    #expect(domains[2].name == "Game C")
}

@Test("SearchTransformer returns empty domains for empty input")
func testTransformResponseToDomain_empty() {
    let transformer = SearchTransformer()
    let domains = transformer.transformResponseToDomain(response: [])
    #expect(domains.isEmpty)
}

@Test("SearchTransformer uses default values for nil search result fields")
func testTransformResponseToDomain_nilFields() {
    let transformer = SearchTransformer()
    let result = SearchResult(
        id: nil,
        name: nil,
        slug: nil,
        playtime: nil,
        released: nil,
        rating: nil,
        score: nil,
        backgroundImage: nil
    )
    
    let domains = transformer.transformResponseToDomain(response: [result])
    
    #expect(domains.count == 1)
    let domain = domains[0]
    #expect(domain.id == 0)
    #expect(domain.name == "Unknown Name")
    #expect(domain.slug == "Unknown Slug")
    #expect(domain.playtime == 0)
    #expect(domain.released == "Unknown released")
    #expect(domain.rating == 0.0)
    #expect(domain.score == "Unknown score")
    #expect(domain.backgroundImage == "")
}

// MARK: - SearchTransformer: Response to Entity

@Test("SearchTransformer transformResponseToEntity returns empty list")
func testTransformResponseToEntity_alwaysEmpty() {
    let transformer = SearchTransformer()
    let results = [makeSearchResult(), makeSearchResult(id: 2, name: "Another Game")]
    
    let entities = transformer.transformResponseToEntity(response: results)
    
    // SearchTransformer.transformResponseToEntity is not implemented (returns [])
    #expect(entities.isEmpty)
}

// MARK: - SearchTransformer: Entity to Domain

@Test("SearchTransformer transformEntityToDomain returns empty list")
func testTransformEntityToDomain_alwaysEmpty() {
    let transformer = SearchTransformer()
    let entity = SearchModuleEntity()
    entity.id = 1
    entity.name = "Test"
    
    let domains = transformer.transformEntityToDomain(entity: [entity])
    
    // SearchTransformer.transformEntityToDomain is not implemented (returns [])
    #expect(domains.isEmpty)
}

// MARK: - SearchDomainModel Tests

@Test("SearchDomainModel initializes with correct values")
func testSearchDomainModelInitialization() {
    let model = SearchDomainModel(
        id: 42,
        name: "Half-Life 3",
        slug: "half-life-3",
        playtime: 20,
        released: "2025-01-01",
        rating: 5.0,
        score: "exceptional",
        backgroundImage: "https://example.com/hl3.jpg"
    )
    
    #expect(model.id == 42)
    #expect(model.name == "Half-Life 3")
    #expect(model.slug == "half-life-3")
    #expect(model.playtime == 20)
    #expect(model.released == "2025-01-01")
    #expect(model.rating == 5.0)
    #expect(model.score == "exceptional")
    #expect(model.backgroundImage == "https://example.com/hl3.jpg")
}

@Test("SearchDomainModel initializes with nil defaults")
func testSearchDomainModelDefaultInit() {
    let model = SearchDomainModel()
    
    #expect(model.id == nil)
    #expect(model.name == nil)
    #expect(model.slug == nil)
    #expect(model.playtime == nil)
    #expect(model.released == nil)
    #expect(model.rating == nil)
    #expect(model.score == nil)
    #expect(model.backgroundImage == nil)
}

@Test("SearchDomainModel equality works correctly")
func testSearchDomainModelEquality() {
    let model1 = SearchDomainModel(id: 1, name: "Game", slug: "game", playtime: 10, released: "2024-01-01", rating: 4.0, score: "good", backgroundImage: "")
    let model2 = SearchDomainModel(id: 1, name: "Game", slug: "game", playtime: 10, released: "2024-01-01", rating: 4.0, score: "good", backgroundImage: "")
    let model3 = SearchDomainModel(id: 2, name: "Different", slug: "different", playtime: 5, released: "2023-01-01", rating: 3.0, score: "meh", backgroundImage: "")
    
    #expect(model1 == model2)
    #expect(model1 != model3)
}

@Test("SearchDomainModel is Identifiable via id")
func testSearchDomainModelIdentifiable() {
    let model = SearchDomainModel(id: 77, name: "Test", slug: "test")
    #expect(model.id == 77)
}

// MARK: - SearchResponse Tests

@Test("SearchResponse initializes correctly")
func testSearchResponseInitialization() {
    let results = [makeSearchResult(id: 1, name: "Test")]
    let response = SearchResponse(count: 1, next: nil, previous: nil, results: results)
    
    #expect(response.count == 1)
    #expect(response.next == nil)
    #expect(response.previous == nil)
    #expect(response.results?.count == 1)
    #expect(response.results?.first?.name == "Test")
}

