import SetSolver
import XCTest

final class CardTests: XCTestCase {
    func test_Card_allCases() {
        let allCards = Card.allCases
        XCTAssertEqual(allCards.count, 81)
        let uniqueCards = Set(allCards)
        XCTAssertEqual(uniqueCards.count, 81)
    }

    func test_matchingCard_color() {
        let card1 = Card(.two, .diamond, .red,    .outlined)
        let card2 = Card(.two, .diamond, .green,  .outlined)
        let expec = Card(.two, .diamond, .purple, .outlined)
        XCTAssertEqual(Card.matchingCard(for: card1, and: card2), expec)
    }

    func test_matchingCard_number() {
        let card1 = Card(.one,   .oval, .red, .solid)
        let card2 = Card(.two,   .oval, .red, .solid)
        let expec = Card(.three, .oval, .red, .solid)
        XCTAssertEqual(Card.matchingCard(for: card1, and: card2), expec)
    }

    func test_matchingCard_shading() {
        let card1 = Card(.two, .squiggle, .green, .solid)
        let card2 = Card(.two, .squiggle, .green, .striped)
        let expec = Card(.two, .squiggle, .green, .outlined)
        XCTAssertEqual(Card.matchingCard(for: card1, and: card2), expec)
    }

    func test_matchingCard_symbol() {
        let card1 = Card(.one, .diamond,  .purple, .striped)
        let card2 = Card(.one, .squiggle, .purple, .striped)
        let expec = Card(.one, .oval,     .purple, .striped)
        XCTAssertEqual(Card.matchingCard(for: card1, and: card2), expec)
    }

    func test_matchingCard_colorAndNumber() {
        let card1 = Card(.three, .oval, .red,    .solid)
        let card2 = Card(.one,   .oval, .green,  .solid)
        let expec = Card(.two,   .oval, .purple, .solid)
        XCTAssertEqual(Card.matchingCard(for: card1, and: card2), expec)
    }

    func test_matchingCard_allVary() {
        let card1 = Card(.one,   .oval,     .purple, .striped)
        let card2 = Card(.two,   .squiggle, .green,  .outlined)
        let expec = Card(.three, .diamond,  .red,    .solid)
        XCTAssertEqual(Card.matchingCard(for: card1, and: card2), expec)
    }
}
