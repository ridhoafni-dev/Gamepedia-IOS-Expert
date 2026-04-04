import Foundation
import Testing

@testable import Genres

// MARK: - GenreTransformer Tests

@Test("GenreTransformer maps genre responses to entities correctly")
func testMapGenresResponsesToEntities_basicFields() {
    let gameInGenre = GameInGenre(
        id: 1,
        name: "GTA V",
        slug: "gta-v",
        added: 100
    )
    let result = GenreResult(
        id: 10,
        name: "Action",
        slug: "action",
        gamesCount: 500,
        imageBackground: "https://example.com/action.jpg",
        games: [gameInGenre]
    )

    let entities = GenreTransformer.mapGenresResponsesToEntities(input: [result]
    )

    #expect(entities.count == 1)
    let entity = entities[0]
    #expect(entity.id == 10)
    #expect(entity.name == "Action")
    #expect(entity.slug == "action")
    #expect(entity.gameCount == 500)
    #expect(entity.imageBackground == "https://example.com/action.jpg")
    #expect(entity.games.count == 1)
    #expect(entity.games.first?.name == "GTA V")
    #expect(entity.games.first?.added == 100)
}

@Test("GenreTransformer maps multiple genre responses to entities")
func testMapGenresResponsesToEntities_multipleItems() {
    let results = [
        GenreResult(
            id: 1,
            name: "Action",
            slug: "action",
            gamesCount: 100,
            imageBackground: "",
            games: []
        ),
        GenreResult(
            id: 2,
            name: "RPG",
            slug: "rpg",
            gamesCount: 80,
            imageBackground: "",
            games: []
        ),
        GenreResult(
            id: 3,
            name: "Strategy",
            slug: "strategy",
            gamesCount: 60,
            imageBackground: "",
            games: []
        ),
    ]

    let entities = GenreTransformer.mapGenresResponsesToEntities(input: results)

    #expect(entities.count == 3)
    #expect(entities[0].id == 1)
    #expect(entities[0].name == "Action")
    #expect(entities[1].id == 2)
    #expect(entities[2].id == 3)
}

@Test("GenreTransformer returns empty entities for empty input")
func testMapGenresResponsesToEntities_empty() {
    let entities = GenreTransformer.mapGenresResponsesToEntities(input: [])
    #expect(entities.isEmpty)
}

@Test("GenreTransformer uses default values for nil genre response fields")
func testMapGenresResponsesToEntities_nilFields() {
    let result = GenreResult(
        id: nil,
        name: nil,
        slug: nil,
        gamesCount: nil,
        imageBackground: nil,
        games: nil
    )

    let entities = GenreTransformer.mapGenresResponsesToEntities(input: [result]
    )

    #expect(entities.count == 1)
    let entity = entities[0]
    #expect(entity.id == 0)
    #expect(entity.name == "Unknown Name")
    #expect(entity.slug == "Unknown Slug")
    #expect(entity.gameCount == 0)
    #expect(entity.imageBackground == "")
    #expect(entity.games.isEmpty)
}

@Test("GenreTransformer maps DetailGenreResponse to single entity")
func testMapGenresResponsesToEntity_detailResponse() {
    let detail = DetailGenreResponse(
        id: 5,
        name: "Indie",
        slug: "indie",
        gamesCount: 300,
        imageBackground: "https://example.com/indie.jpg",
        description: "Independent games made by small studios"
    )

    let entity = GenreTransformer.mapGenresResponsesToEntity(input: detail)

    #expect(entity.id == 5)
    #expect(entity.name == "Indie")
    #expect(entity.slug == "indie")
    #expect(entity.gameCount == 300)
    #expect(entity.imageBackground == "https://example.com/indie.jpg")
    #expect(entity.desc == "Independent games made by small studios")
}

@Test("GenreTransformer maps entities to domains correctly")
func testMapGenresEntitiesToDomains_basicFields() {
    let result = GenreResult(
        id: 15,
        name: "Simulation",
        slug: "simulation",
        gamesCount: 200,
        imageBackground: "https://example.com/sim.jpg",
        games: [
            GameInGenre(
                id: 2,
                name: "Cities Skylines",
                slug: "cities-skylines",
                added: 50
            )
        ]
    )
    let entities = GenreTransformer.mapGenresResponsesToEntities(input: [result]
    )

    let domains = GenreTransformer.mapGenresEntitiesToDomains(input: entities)

    #expect(domains.count == 1)
    let domain = domains[0]
    #expect(domain.id == 15)
    #expect(domain.name == "Simulation")
    #expect(domain.slug == "simulation")
    #expect(domain.gamesCount == 200)
    #expect(domain.games.count == 1)
    #expect(domain.games[0].name == "Cities Skylines")
}

@Test("GenreTransformer maps empty entities to empty domains")
func testMapGenresEntitiesToDomains_empty() {
    let domains = GenreTransformer.mapGenresEntitiesToDomains(input: [])
    #expect(domains.isEmpty)
}

@Test("GenreTransformer maps single entity to domain with description")
func testMapGenresEntityToDomains_withDescription() {
    let detail = DetailGenreResponse(
        id: 7,
        name: "Adventure",
        slug: "adventure",
        gamesCount: 400,
        imageBackground: "https://example.com/adv.jpg",
        description: "Story-driven exploration games"
    )
    let entity = GenreTransformer.mapGenresResponsesToEntity(input: detail)

    let domain = GenreTransformer.mapGenresEntityToDomains(input: entity)

    #expect(domain.id == 7)
    #expect(domain.name == "Adventure")
    #expect(domain.slug == "adventure")
    #expect(domain.gamesCount == 400)
    #expect(domain.desc == "Story-driven exploration games")
}

@Test("GenreTransformer maps genre responses directly to domains")
func testMapGenreResponsesToDomains_basicFields() {
    let results = [
        GenreResult(
            id: 1,
            name: "Action",
            slug: "action",
            gamesCount: 100,
            imageBackground: "https://example.com/action.jpg",
            games: [
                GameInGenre(
                    id: 5,
                    name: "Call of Duty",
                    slug: "cod",
                    added: 300
                )
            ]
        )
    ]

    let domains = GenreTransformer.mapGenreResponsesToDomains(input: results)

    #expect(domains.count == 1)
    let domain = domains[0]
    #expect(domain.id == 1)
    #expect(domain.name == "Action")
    #expect(domain.slug == "action")
    #expect(domain.gamesCount == 100)
    #expect(domain.imageBackground == "https://example.com/action.jpg")
    #expect(domain.games.count == 1)
    #expect(domain.games[0].id == 5)
    #expect(domain.games[0].name == "Call of Duty")
    #expect(domain.games[0].added == 300)
}

@Test("GenreTransformer maps responses to domains for multiple genres")
func testMapGenreResponsesToDomains_multipleItems() {
    let results = [
        GenreResult(
            id: 1,
            name: "Action",
            slug: "action",
            gamesCount: 100,
            imageBackground: "",
            games: []
        ),
        GenreResult(
            id: 2,
            name: "Sports",
            slug: "sports",
            gamesCount: 70,
            imageBackground: "",
            games: []
        ),
    ]

    let domains = GenreTransformer.mapGenreResponsesToDomains(input: results)

    #expect(domains.count == 2)
    #expect(domains[0].name == "Action")
    #expect(domains[1].name == "Sports")
}

@Test("GenreTransformer returns empty domains for empty input")
func testMapGenreResponsesToDomains_empty() {
    let domains = GenreTransformer.mapGenreResponsesToDomains(input: [])
    #expect(domains.isEmpty)
}

@Test("GenreTransformer maps nil game fields with defaults in domain")
func testMapGenreResponsesToDomains_nilGameFields() {
    let results = [
        GenreResult(
            id: 1,
            name: "Puzzle",
            slug: "puzzle",
            gamesCount: 50,
            imageBackground: "",
            games: [GameInGenre(id: nil, name: nil, slug: nil, added: nil)]
        )
    ]

    let domains = GenreTransformer.mapGenreResponsesToDomains(input: results)

    #expect(domains.count == 1)
    #expect(domains[0].games.count == 1)
    let game = domains[0].games[0]
    #expect(game.id == 0)
    #expect(game.name == "Unknown Name")
    #expect(game.slug == "Unknown Slug")
    #expect(game.added == 0)
}

// MARK: - GenreDomainModel Tests

@Test("GenreDomainModel initializes with correct values")
func testGenreDomainModelInitialization() {
    let games = [
        GameInGenreModel(
            id: 1,
            name: "Puzzle Game",
            slug: "puzzle-game",
            added: 50
        )
    ]
    let model = GenreDomainModel(
        id: 3,
        name: "Puzzle",
        slug: "puzzle",
        gamesCount: 120,
        imageBackground: "https://example.com/puzzle.jpg",
        games: games
    )

    #expect(model.id == 3)
    #expect(model.name == "Puzzle")
    #expect(model.slug == "puzzle")
    #expect(model.gamesCount == 120)
    #expect(model.desc == "Unknown Description")
    #expect(model.games.count == 1)
    #expect(model.games[0].name == "Puzzle Game")
}

@Test("GenreDomainModel initializes with custom description")
func testGenreDomainModelWithCustomDescription() {
    let model = GenreDomainModel(
        id: 1,
        name: "Horror",
        slug: "horror",
        gamesCount: 80,
        imageBackground: "",
        desc: "Terrifying survival games",
        games: []
    )

    #expect(model.desc == "Terrifying survival games")
}

@Test("GenreDomainModel equality works correctly")
func testGenreDomainModelEquality() {
    let games = [GameInGenreModel(id: 1, name: "X", slug: "x", added: 10)]
    let model1 = GenreDomainModel(
        id: 1,
        name: "Action",
        slug: "action",
        gamesCount: 100,
        imageBackground: "",
        games: games
    )
    let model2 = GenreDomainModel(
        id: 1,
        name: "Action",
        slug: "action",
        gamesCount: 100,
        imageBackground: "",
        games: games
    )
    let model3 = GenreDomainModel(
        id: 2,
        name: "RPG",
        slug: "rpg",
        gamesCount: 50,
        imageBackground: "",
        games: []
    )

    #expect(model1 == model2)
    #expect(model1 != model3)
}
