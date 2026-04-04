import Foundation
import Testing
@testable import Developers

// MARK: - Test Data Helpers

private func makeDeveloperResult(
    id: Int = 1,
    name: String = "CD Projekt Red",
    slug: String = "cd-projekt-red",
    gamesCount: Int = 10,
    imageBackground: String = "https://example.com/cdpr.jpg",
    games: [GameInDeveloper] = []
) -> DeveloperResult {
    return DeveloperResult(
        id: id,
        name: name,
        slug: slug,
        gamesCount: gamesCount,
        imageBackground: imageBackground,
        games: games
    )
}

private func makeGameInDeveloper(id: Int = 1, name: String = "Game", slug: String = "game", added: Int = 100) -> GameInDeveloper {
    return GameInDeveloper(id: id, name: name, slug: slug, added: added)
}

// MARK: - DeveloperTransformer: Response to Entity

@Test("DeveloperTransformer maps response to entity correctly")
func testTransformResponseToEntity_basicFields() {
    let transformer = DeveloperTransformer()
    let gameInDev = makeGameInDeveloper(id: 5, name: "Cyberpunk 2077", slug: "cyberpunk-2077", added: 250)
    let result = makeDeveloperResult(
        id: 10,
        name: "CD Projekt Red",
        slug: "cd-projekt-red",
        gamesCount: 5,
        imageBackground: "https://example.com/cdpr.jpg",
        games: [gameInDev]
    )

    let entities = transformer.transformResponseToEntity(response: [result])

    #expect(entities.count == 1)
    let entity = entities[0]
    #expect(entity.id == "10")
    #expect(entity.name == "CD Projekt Red")
    #expect(entity.slug == "cd-projekt-red")
    #expect(entity.gameCount == 5)
    #expect(entity.imageBackground == "https://example.com/cdpr.jpg")
    #expect(entity.games.count == 1)
    #expect(entity.games.first?.id == "5")
    #expect(entity.games.first?.name == "Cyberpunk 2077")
    #expect(entity.games.first?.added == 250)
}

@Test("DeveloperTransformer maps multiple responses to entities")
func testTransformResponseToEntity_multipleItems() {
    let transformer = DeveloperTransformer()
    let responses = [
        makeDeveloperResult(id: 1, name: "Naughty Dog", games: [makeGameInDeveloper()]),
        makeDeveloperResult(id: 2, name: "Rockstar Games", games: [makeGameInDeveloper()])
    ]

    let entities = transformer.transformResponseToEntity(response: responses)

    #expect(entities.count == 2)
    #expect(entities[0].id == "1")
    #expect(entities[0].name == "Naughty Dog")
    #expect(entities[1].id == "2")
    #expect(entities[1].name == "Rockstar Games")
}

@Test("DeveloperTransformer maps empty response array to empty entities")
func testTransformResponseToEntity_empty() {
    let transformer = DeveloperTransformer()
    let entities = transformer.transformResponseToEntity(response: [])
    #expect(entities.isEmpty)
}

@Test("DeveloperTransformer uses default values for nil response fields")
func testTransformResponseToEntity_nilFields() {
    let transformer = DeveloperTransformer()
    let result = DeveloperResult(id: nil, name: nil, slug: nil, gamesCount: nil, imageBackground: nil, games: [])

    let entities = transformer.transformResponseToEntity(response: [result])

    #expect(entities.count == 1)
    let entity = entities[0]
    #expect(entity.id == "0")
    #expect(entity.name == "Unknown Name")
    #expect(entity.slug == "Unknown Slug")
    #expect(entity.gameCount == 0)
    #expect(entity.imageBackground == "")
}

@Test("DeveloperTransformer maps multiple games within a developer")
func testTransformResponseToEntity_multipleGames() {
    let transformer = DeveloperTransformer()
    let games = [
        makeGameInDeveloper(id: 1, name: "The Last of Us", slug: "the-last-of-us", added: 300),
        makeGameInDeveloper(id: 2, name: "Uncharted 4", slug: "uncharted-4", added: 250)
    ]
    let result = makeDeveloperResult(id: 7, name: "Naughty Dog", games: games)

    let entities = transformer.transformResponseToEntity(response: [result])

    #expect(entities.count == 1)
    #expect(entities[0].games.count == 2)
    #expect(entities[0].games[0].name == "The Last of Us")
    #expect(entities[0].games[1].name == "Uncharted 4")
}

// MARK: - DeveloperTransformer: Entity to Domain

@Test("DeveloperTransformer maps entity to domain correctly")
func testTransformEntityToDomain_basicFields() {
    let transformer = DeveloperTransformer()
    let gameInDev = makeGameInDeveloper(id: 3, name: "GTA V", slug: "gta-v", added: 150)
    let result = makeDeveloperResult(id: 20, name: "Rockstar", slug: "rockstar", gamesCount: 8, games: [gameInDev])
    let entities = transformer.transformResponseToEntity(response: [result])

    let domains = transformer.transformEntityToDomain(entity: entities)

    #expect(domains.count == 1)
    let domain = domains[0]
    #expect(domain.id == 20)
    #expect(domain.name == "Rockstar")
    #expect(domain.slug == "rockstar")
    #expect(domain.gamesCount == 8)
    #expect(domain.games.count == 1)
    #expect(domain.games[0].id == 3)
    #expect(domain.games[0].name == "GTA V")
    #expect(domain.games[0].slug == "gta-v")
    #expect(domain.games[0].added == 150)
}

@Test("DeveloperTransformer maps multiple entities to domains")
func testTransformEntityToDomain_multipleItems() {
    let transformer = DeveloperTransformer()
    let responses = [
        makeDeveloperResult(id: 1, name: "Epic Games", games: [makeGameInDeveloper()]),
        makeDeveloperResult(id: 2, name: "Valve", games: [makeGameInDeveloper()])
    ]
    let entities = transformer.transformResponseToEntity(response: responses)
    let domains = transformer.transformEntityToDomain(entity: entities)

    #expect(domains.count == 2)
    #expect(domains[0].id == 1)
    #expect(domains[0].name == "Epic Games")
    #expect(domains[1].id == 2)
    #expect(domains[1].name == "Valve")
}

@Test("DeveloperTransformer maps empty entities to empty domains")
func testTransformEntityToDomain_empty() {
    let transformer = DeveloperTransformer()
    let domains = transformer.transformEntityToDomain(entity: [])
    #expect(domains.isEmpty)
}

// MARK: - DeveloperDomainModel Tests

@Test("DeveloperDomainModel initializes with correct values")
func testDeveloperDomainModelInitialization() {
    let games = [
        GameInDeveloperDomainModel(id: 1, name: "Game One", slug: "game-one", added: 100)
    ]
    let developer = DeveloperDomainModel(
        id: 42,
        name: "Bethesda",
        slug: "bethesda",
        gamesCount: 20,
        imageBackground: "https://example.com/bethesda.jpg",
        games: games
    )

    #expect(developer.id == 42)
    #expect(developer.name == "Bethesda")
    #expect(developer.slug == "bethesda")
    #expect(developer.gamesCount == 20)
    #expect(developer.imageBackground == "https://example.com/bethesda.jpg")
    #expect(developer.games.count == 1)
    #expect(developer.games[0].name == "Game One")
}

@Test("DeveloperDomainModel equality works correctly")
func testDeveloperDomainModelEquality() {
    let games = [GameInDeveloperDomainModel(id: 1, name: "X", slug: "x", added: 10)]
    let dev1 = DeveloperDomainModel(id: 1, name: "Dev", slug: "dev", gamesCount: 5, imageBackground: "", games: games)
    let dev2 = DeveloperDomainModel(id: 1, name: "Dev", slug: "dev", gamesCount: 5, imageBackground: "", games: games)
    let dev3 = DeveloperDomainModel(id: 2, name: "Other", slug: "other", gamesCount: 3, imageBackground: "", games: [])

    #expect(dev1 == dev2)
    #expect(dev1 != dev3)
}

@Test("GameInDeveloperDomainModel initializes with correct values")
func testGameInDeveloperDomainModelInitialization() {
    let game = GameInDeveloperDomainModel(id: 7, name: "Horizon Zero Dawn", slug: "horizon-zero-dawn", added: 500)

    #expect(game.id == 7)
    #expect(game.name == "Horizon Zero Dawn")
    #expect(game.slug == "horizon-zero-dawn")
    #expect(game.added == 500)
}

