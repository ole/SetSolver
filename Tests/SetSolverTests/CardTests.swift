import SetSolver
import Testing

@Suite struct CardTests {
    @Test func Card_allCases() {
        let allCards = Card.allCases
        #expect(allCards.count == 81)
        let uniqueCards = Set(allCards)
        #expect(uniqueCards.count == 81)
    }

    @Test func matchingCard_color() {
        let card1 = Card(.two, .diamond, .red,    .outlined)
        let card2 = Card(.two, .diamond, .green,  .outlined)
        let expec = Card(.two, .diamond, .purple, .outlined)
        #expect(Card.matchingCard(for: card1, and: card2) == expec)
    }

    @Test func matchingCard_number() {
        let card1 = Card(.one,   .oval, .red, .solid)
        let card2 = Card(.two,   .oval, .red, .solid)
        let expec = Card(.three, .oval, .red, .solid)
        #expect(Card.matchingCard(for: card1, and: card2) == expec)
    }

    @Test func matchingCard_shading() {
        let card1 = Card(.two, .squiggle, .green, .solid)
        let card2 = Card(.two, .squiggle, .green, .striped)
        let expec = Card(.two, .squiggle, .green, .outlined)
        #expect(Card.matchingCard(for: card1, and: card2) == expec)
    }

    @Test func matchingCard_symbol() {
        let card1 = Card(.one, .diamond,  .purple, .striped)
        let card2 = Card(.one, .squiggle, .purple, .striped)
        let expec = Card(.one, .oval,     .purple, .striped)
        #expect(Card.matchingCard(for: card1, and: card2) == expec)
    }

    @Test func matchingCard_colorAndNumber() {
        let card1 = Card(.three, .oval, .red,    .solid)
        let card2 = Card(.one,   .oval, .green,  .solid)
        let expec = Card(.two,   .oval, .purple, .solid)
        #expect(Card.matchingCard(for: card1, and: card2) == expec)
    }

    @Test func matchingCard_allVary() {
        let card1 = Card(.one,   .oval,     .purple, .striped)
        let card2 = Card(.two,   .squiggle, .green,  .outlined)
        let expec = Card(.three, .diamond,  .red,    .solid)
        #expect(Card.matchingCard(for: card1, and: card2) == expec)
    }
}
