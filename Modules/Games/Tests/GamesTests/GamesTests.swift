import Foundation
import Testing

@testable import Games

// MARK: - GameTransformer Tests

@Test("GameTransformer maps single game response to domain")
func testMapGameResponsesToDomains_singleItem() {
    let response = GameResultFactory.make(
        id: 10,
        name: "The Witcher 3",
        released: "2015-05-19",
        backgroundImage: "https://media.rawg.io/witcher3.jpg",
        rating: 4.7,
        ratingTop: 5,
        suggestionsCount: 500,
        updated: "2024-01-01",
        reviewsCount: 300,
        communityRating: 5
    )

    let domains = GameTransformer.mapGameResponsesToDomains(input: [response])

    #expect(domains.count == 1)
    let domain = domains[0]
    #expect(domain.id == 10)
    #expect(domain.name == "The Witcher 3")
    #expect(domain.released == "2015-05-19")
    #expect(domain.backgroundImage == "https://media.rawg.io/witcher3.jpg")
    #expect(domain.rating == 4.7)
    #expect(domain.ratingTop == 5)
    #expect(domain.suggestionsCount == 500)
    #expect(domain.reviewsCount == 300)
    #expect(domain.communityRating == 5)
    #expect(domain.updated == "2024-01-01")
}

@Test("GameTransformer maps multiple game responses to domains")
func testMapGameResponsesToDomains_multipleItems() {
    let responses = [
        GameResultFactory.make(id: 1, name: "Game One"),
        GameResultFactory.make(id: 2, name: "Game Two"),
        GameResultFactory.make(id: 3, name: "Game Three"),
    ]

    let domains = GameTransformer.mapGameResponsesToDomains(input: responses)

    #expect(domains.count == 3)
    #expect(domains[0].id == 1)
    #expect(domains[1].id == 2)
    #expect(domains[2].id == 3)
    #expect(domains[0].name == "Game One")
    #expect(domains[1].name == "Game Two")
    #expect(domains[2].name == "Game Three")
}

@Test("GameTransformer returns empty array for empty input")
func testMapGameResponsesToDomains_emptyArray() {
    let domains = GameTransformer.mapGameResponsesToDomains(input: [])

    #expect(domains.isEmpty)
}

@Test("GameTransformer uses default values for nil fields")
func testMapGameResponsesToDomains_nilValues() {
    let response = GameResultFactory.makeNilFields()

    let domains = GameTransformer.mapGameResponsesToDomains(input: [response])

    #expect(domains.count == 1)
    let domain = domains[0]
    #expect(domain.id == 0)
    #expect(domain.name == "Unknown Name")
    #expect(domain.released == "Unknown Release")
    #expect(domain.backgroundImage == "")
    #expect(domain.rating == 0.0)
    #expect(domain.ratingTop == 0.0)
    #expect(domain.suggestionsCount == 0)
    #expect(domain.updated == "Unknown date")
    #expect(domain.reviewsCount == 0)
    #expect(domain.communityRating == 0)
}

// MARK: - DetailGameTransformer: Response to Entity (from [GameResult])

@Test("DetailGameTransformer maps GameResult array to entities")
func testMapDetailGameResponseToEntities_fromGameResults() {
    let responses = [
        GameResultFactory.make(
            id: 5,
            name: "Entity Game",
            released: "2023-03-15",
            rating: 3.8,
            suggestionsCount: 20,
            reviewsCount: 10
        )
    ]

    let entities = DetailGameTransformer.mapDetailGameResponseToEntities(
        input: responses
    )

    #expect(entities.count == 1)
    let entity = entities[0]
    #expect(entity.id == 5)
    #expect(entity.name == "Entity Game")
    #expect(entity.released == "2023-03-15")
    #expect(entity.rating == 3.8)
    #expect(entity.suggestionsCount == 20)
    #expect(entity.reviewsCount == 10)
    #expect(entity.isFavorite == false)
}

@Test("DetailGameTransformer maps multiple GameResults to entities")
func testMapDetailGameResponseToEntities_multiple() {
    let responses = [
        GameResultFactory.make(id: 1, name: "Alpha"),
        GameResultFactory.make(id: 2, name: "Beta"),
    ]

    let entities = DetailGameTransformer.mapDetailGameResponseToEntities(
        input: responses
    )

    #expect(entities.count == 2)
    #expect(entities[0].id == 1)
    #expect(entities[0].name == "Alpha")
    #expect(entities[1].id == 2)
    #expect(entities[1].name == "Beta")
}

@Test("DetailGameTransformer returns empty array for empty GameResult input")
func testMapDetailGameResponseToEntities_empty() {
    let entities = DetailGameTransformer.mapDetailGameResponseToEntities(
        input: [])
    #expect(entities.isEmpty)
}

// MARK: - DetailGameTransformer: Entities to Domains

@Test("DetailGameTransformer maps single entity to domain")
func testMapDetailGameEntitiesToDomains_singleItem() {
    let entity = GameModuleEntityFactory.make(
        id: 42,
        name: "Red Dead Redemption 2",
        slug: "red-dead-redemption-2",
        released: "2018-10-26",
        rating: 4.9,
        isFavorite: true
    )

    let domains = DetailGameTransformer.mapDetailGameEntitiesToDomains(input: [
        entity
    ])

    #expect(domains.count == 1)
    let domain = domains[0]
    #expect(domain.id == 42)
    #expect(domain.name == "Red Dead Redemption 2")
    #expect(domain.slug == "red-dead-redemption-2")
    #expect(domain.released == "2018-10-26")
    #expect(domain.rating == 4.9)
    #expect(domain.isFavorite == true)
    #expect(domain.description == "A test description")
}

@Test("DetailGameTransformer maps multiple entities to domains")
func testMapDetailGameEntitiesToDomains_multipleItems() {
    let entities = [
        GameModuleEntityFactory.make(id: 1, name: "Game A"),
        GameModuleEntityFactory.make(id: 2, name: "Game B"),
        GameModuleEntityFactory.make(id: 3, name: "Game C"),
    ]

    let domains = DetailGameTransformer.mapDetailGameEntitiesToDomains(
        input: entities
    )

    #expect(domains.count == 3)
    #expect(domains[0].id == 1)
    #expect(domains[0].name == "Game A")
    #expect(domains[1].id == 2)
    #expect(domains[2].id == 3)
}

@Test("DetailGameTransformer returns empty array for empty entities")
func testMapDetailGameEntitiesToDomains_empty() {
    let domains = DetailGameTransformer.mapDetailGameEntitiesToDomains(input: []
    )
    #expect(domains.isEmpty)
}

@Test("DetailGameTransformer maps isFavorite false correctly")
func testMapDetailGameEntitiesToDomains_notFavorite() {
    let entity = GameModuleEntityFactory.make(id: 7, isFavorite: false)

    let domains = DetailGameTransformer.mapDetailGameEntitiesToDomains(input: [
        entity
    ])

    #expect(domains.count == 1)
    #expect(domains[0].isFavorite == false)
}

@Test("DetailGameTransformer preserves all entity fields in domain")
func testMapDetailGameEntitiesToDomains_fieldsPreserved() {
    let entity = GameModuleEntityFactory.make(
        id: 15,
        name: "Elden Ring",
        rating: 4.95
    )
    entity.playtime = 100
    entity.achievementsCount = 50
    entity.ratingsCount = 5000
    entity.added = 999
    entity.website = "https://eldenring.com"

    let domains = DetailGameTransformer.mapDetailGameEntitiesToDomains(input: [
        entity
    ])

    let domain = domains[0]
    #expect(domain.playtime == 100)
    #expect(domain.achievementsCount == 50)
    #expect(domain.ratingsCount == 5000)
    #expect(domain.added == 999)
    #expect(domain.website == "https://eldenring.com")
    #expect(domain.rating == 4.95)
}

// MARK: - GameDomainModel Tests

@Test("GameDomainModel initializes with correct values")
func testGameDomainModelInitialization() {
    let model = GameDomainModel(
        id: 1,
        name: "Portal 2",
        released: "2011-04-19",
        backgroundImage: "https://example.com/portal2.jpg",
        rating: 4.8,
        ratingTop: 5,
        suggestionsCount: 200,
        updated: "2024-01-01",
        reviewsCount: 150,
        communityRating: 5,
        platforms: nil,
        genres: nil,
        parentPlatforms: nil
    )

    #expect(model.id == 1)
    #expect(model.name == "Portal 2")
    #expect(model.released == "2011-04-19")
    #expect(model.rating == 4.8)
    #expect(model.ratingTop == 5)
    #expect(model.suggestionsCount == 200)
    #expect(model.reviewsCount == 150)
    #expect(model.communityRating == 5)
    #expect(model.platforms == nil)
    #expect(model.genres == nil)
    #expect(model.parentPlatforms == nil)
}

@Test("GameDomainModel equality works correctly")
func testGameDomainModelEquality() {
    let model1 = GameDomainModel(
        id: 5,
        name: "Test",
        released: "2020-01-01",
        backgroundImage: "",
        rating: 4.0,
        ratingTop: 5.0,
        suggestionsCount: 10,
        updated: "2024-01-01",
        reviewsCount: 5,
        communityRating: 4,
        platforms: nil,
        genres: nil,
        parentPlatforms: nil
    )
    let model2 = GameDomainModel(
        id: 5,
        name: "Test",
        released: "2020-01-01",
        backgroundImage: "",
        rating: 4.0,
        ratingTop: 5.0,
        suggestionsCount: 10,
        updated: "2024-01-01",
        reviewsCount: 5,
        communityRating: 4,
        platforms: nil,
        genres: nil,
        parentPlatforms: nil
    )
    let model3 = GameDomainModel(
        id: 6,
        name: "Different",
        released: "2021-01-01",
        backgroundImage: "",
        rating: 3.0,
        ratingTop: 4.0,
        suggestionsCount: 5,
        updated: "2023-01-01",
        reviewsCount: 2,
        communityRating: 3,
        platforms: nil,
        genres: nil,
        parentPlatforms: nil
    )

    #expect(model1 == model2)
    #expect(model1 != model3)
}

// MARK: - DetailGameDomainModel Tests

@Test("DetailGameDomainModel initializes with all required fields")
func testDetailGameDomainModelInitialization() {
    let model = DetailGameDomainModel(
        id: 100,
        isFavorite: false,
        slug: "test-game",
        name: "Test Game",
        nameOriginal: "Original Test Game",
        description: "A fantastic game",
        released: "2022-05-10",
        updated: "2024-01-01",
        backgroundImage: "https://example.com/bg.jpg",
        backgroundImageAdditional: nil,
        website: "https://testgame.com",
        rating: 4.6,
        added: 500,
        playtime: 25,
        achievementsCount: 60,
        ratingsCount: 900,
        suggestionsCount: 120,
        reviewsCount: 400,
        parentPlatforms: nil,
        platforms: nil,
        stores: nil,
        developers: nil,
        genres: nil,
        tags: nil,
        publishers: nil,
        descriptionRaw: "Raw text description"
    )

    #expect(model.id == 100)
    #expect(model.isFavorite == false)
    #expect(model.slug == "test-game")
    #expect(model.name == "Test Game")
    #expect(model.rating == 4.6)
    #expect(model.playtime == 25)
    #expect(model.added == 500)
    #expect(model.descriptionRaw == "Raw text description")
}

@Test("DetailGameDomainModel equality works correctly")
func testDetailGameDomainModelEquality() {
    let model1 = DetailGameDomainModel(
        id: 1,
        isFavorite: true,
        slug: "game",
        name: "Game",
        nameOriginal: nil,
        description: nil,
        released: nil,
        updated: nil,
        backgroundImage: nil,
        backgroundImageAdditional: nil,
        website: nil,
        rating: nil,
        added: nil,
        playtime: nil,
        achievementsCount: nil,
        ratingsCount: nil,
        suggestionsCount: nil,
        reviewsCount: nil,
        parentPlatforms: nil,
        platforms: nil,
        stores: nil,
        developers: nil,
        genres: nil,
        tags: nil,
        publishers: nil,
        descriptionRaw: nil
    )
    let model2 = DetailGameDomainModel(
        id: 1,
        isFavorite: true,
        slug: "game",
        name: "Game",
        nameOriginal: nil,
        description: nil,
        released: nil,
        updated: nil,
        backgroundImage: nil,
        backgroundImageAdditional: nil,
        website: nil,
        rating: nil,
        added: nil,
        playtime: nil,
        achievementsCount: nil,
        ratingsCount: nil,
        suggestionsCount: nil,
        reviewsCount: nil,
        parentPlatforms: nil,
        platforms: nil,
        stores: nil,
        developers: nil,
        genres: nil,
        tags: nil,
        publishers: nil,
        descriptionRaw: nil
    )

    #expect(model1 == model2)
}
