import Foundation
import Testing
@testable import Favorite

import Games
// MARK: - FavoriteTransformer Tests

@Test("FavoriteTransformer transforms entity list to domain list correctly")
func testTransformEntityToDomain_basicFields() {
    let transformer = FavoriteTransformer()

    let entity = GameModuleEntity()
    entity.id = 1
    entity.name = "The Witcher 3"
    entity.slug = "the-witcher-3"
    entity.originalName = "Wiedźmin 3"
    entity.desc = "An epic RPG"
    entity.released = "2015-05-19"
    entity.updated = "2024-01-01"
    entity.backgroundImage = "https://example.com/witcher3.jpg"
    entity.rating = 4.9
    entity.isFavorite = true
    entity.playtime = 200
    entity.added = 1000

    let domains = transformer.transformEntityToDomain(entity: [entity])

    #expect(domains.count == 1)
    let domain = domains[0]
    #expect(domain.id == 1)
    #expect(domain.name == "The Witcher 3")
    #expect(domain.slug == "the-witcher-3")
    #expect(domain.rating == 4.9)
    #expect(domain.isFavorite == true)
    #expect(domain.playtime == 200)
    #expect(domain.added == 1000)
}

@Test("FavoriteTransformer transforms multiple entities to domains")
func testTransformEntityToDomain_multipleEntities() {
    let transformer = FavoriteTransformer()

    let entity1 = GameModuleEntity()
    entity1.id = 1
    entity1.name = "Game Alpha"
    entity1.isFavorite = true

    let entity2 = GameModuleEntity()
    entity2.id = 2
    entity2.name = "Game Beta"
    entity2.isFavorite = false

    let entity3 = GameModuleEntity()
    entity3.id = 3
    entity3.name = "Game Gamma"
    entity3.isFavorite = true

    let domains = transformer.transformEntityToDomain(entity: [entity1, entity2, entity3])

    #expect(domains.count == 3)
    #expect(domains[0].id == 1)
    #expect(domains[0].name == "Game Alpha")
    #expect(domains[0].isFavorite == true)
    #expect(domains[1].id == 2)
    #expect(domains[1].name == "Game Beta")
    #expect(domains[1].isFavorite == false)
    #expect(domains[2].id == 3)
    #expect(domains[2].name == "Game Gamma")
}

@Test("FavoriteTransformer returns empty domains for empty entity list")
func testTransformEntityToDomain_empty() {
    let transformer = FavoriteTransformer()
    let domains = transformer.transformEntityToDomain(entity: [])
    #expect(domains.isEmpty)
}

@Test("FavoriteTransformer preserves all entity fields in domain")
func testTransformEntityToDomain_allFieldsPreserved() {
    let transformer = FavoriteTransformer()

    let entity = GameModuleEntity()
    entity.id = 99
    entity.slug = "elden-ring"
    entity.name = "Elden Ring"
    entity.originalName = "Elden Ring Original"
    entity.desc = "Open world action RPG"
    entity.released = "2022-02-25"
    entity.updated = "2024-06-01"
    entity.backgroundImage = "https://example.com/eldenring.jpg"
    entity.backgroundImageAdditional = "https://example.com/eldenring2.jpg"
    entity.website = "https://eldenring.com"
    entity.rating = 4.95
    entity.added = 2000
    entity.playtime = 80
    entity.achievementsCount = 100
    entity.ratingsCount = 5000
    entity.suggestionsCount = 250
    entity.reviewsCount = 1500
    entity.descriptionRaw = "FromSoftware's open-world RPG."
    entity.isFavorite = true

    let domains = transformer.transformEntityToDomain(entity: [entity])

    #expect(domains.count == 1)
    let domain = domains[0]
    #expect(domain.id == 99)
    #expect(domain.slug == "elden-ring")
    #expect(domain.nameOriginal == "Elden Ring Original")
    #expect(domain.description == "Open world action RPG")
    #expect(domain.backgroundImageAdditional == "https://example.com/eldenring2.jpg")
    #expect(domain.website == "https://eldenring.com")
    #expect(domain.achievementsCount == 100)
    #expect(domain.ratingsCount == 5000)
    #expect(domain.suggestionsCount == 250)
    #expect(domain.reviewsCount == 1500)
    #expect(domain.descriptionRaw == "FromSoftware's open-world RPG.")
}

@Test("FavoriteTransformer transformResponseToDomain returns empty list")
func testTransformResponseToDomain_alwaysEmpty() {
    let transformer = FavoriteTransformer()
    let result = transformer.transformResponseToDomain(response: true)
    #expect(result.isEmpty)
}

@Test("FavoriteTransformer transformResponseToEntity returns empty list")
func testTransformResponseToEntity_alwaysEmpty() {
    let transformer = FavoriteTransformer()
    let result = transformer.transformResponseToEntity(response: false)
    #expect(result.isEmpty)
}

