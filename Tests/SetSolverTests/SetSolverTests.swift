import XCTest
import SetSolver

final class SetSolverTests: XCTestCase {
    func test_Card_allCases() {
        let allCards = Card.allCases
        XCTAssertEqual(allCards.count, 81)
        let uniqueCards = Set(allCards)
        XCTAssertEqual(uniqueCards.count, 81)
    }

    func test_matchingCard_color() {
        let card1 = Card(.red,    .two, .outlined, .diamond)
        let card2 = Card(.green,  .two, .outlined, .diamond)
        let expec = Card(.purple, .two, .outlined, .diamond)
        XCTAssertEqual(Card.matchingCard(for: card1, and: card2), expec)
    }

    func test_matchingCard_number() {
        let card1 = Card(.red, .one,   .solid, .oval)
        let card2 = Card(.red, .two,   .solid, .oval)
        let expec = Card(.red, .three, .solid, .oval)
        XCTAssertEqual(Card.matchingCard(for: card1, and: card2), expec)
    }

    func test_matchingCard_shading() {
        let card1 = Card(.green, .two, .solid,    .squiggle)
        let card2 = Card(.green, .two, .striped,  .squiggle)
        let expec = Card(.green, .two, .outlined, .squiggle)
        XCTAssertEqual(Card.matchingCard(for: card1, and: card2), expec)
    }

    func test_matchingCard_symbol() {
        let card1 = Card(.purple, .one, .striped, .diamond)
        let card2 = Card(.purple, .one, .striped, .squiggle)
        let expec = Card(.purple, .one, .striped, .oval)
        XCTAssertEqual(Card.matchingCard(for: card1, and: card2), expec)
    }

    func test_matchingCard_colorAndNumber() {
        let card1 = Card(.red,    .three, .solid, .oval)
        let card2 = Card(.green,  .one,   .solid, .oval)
        let expec = Card(.purple, .two,   .solid, .oval)
        XCTAssertEqual(Card.matchingCard(for: card1, and: card2), expec)
    }

    func test_matchingCard_allVary() {
        let card1 = Card(.purple, .one,   .striped,  .oval)
        let card2 = Card(.green,  .two,   .outlined, .squiggle)
        let expec = Card(.red,    .three, .solid,    .diamond)
        XCTAssertEqual(Card.matchingCard(for: card1, and: card2), expec)
    }
}
