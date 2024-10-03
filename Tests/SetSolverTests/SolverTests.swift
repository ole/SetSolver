import SetSolver
import Testing

@Suite struct SolverTests {
    @Test func findValidSets() {
        let red_1_out_dia = Card(.one,   .diamond,  .red,   .outlined)
        let red_2_out_dia = Card(.two,   .diamond,  .red,   .outlined)
        let red_3_out_dia = Card(.three, .diamond,  .red,   .outlined)
        let gre_1_out_dia = Card(.one,   .diamond,  .green, .outlined)
        let gre_2_sol_squ = Card(.two,   .squiggle, .green, .solid)
        let gre_3_str_ova = Card(.three, .oval,     .green, .striped)
        let cards: Set<Card> = [
            red_1_out_dia, gre_1_out_dia, red_3_out_dia, red_2_out_dia, gre_2_sol_squ, gre_3_str_ova,
        ]
        let actual = SetSolver.findSets(cards: cards)
        let expected: Set<Set<Card>> = [
            [red_1_out_dia, red_2_out_dia, red_3_out_dia],
            [gre_1_out_dia, gre_2_sol_squ, gre_3_str_ova],
        ]
        // For debugging test failures:
//        let string = actual.map { set in
//            set.map(\.notation)
//                .joined(separator: " ")
//        }.joined(separator: "\n")
//        print(string)
        #expect(actual == expected)
    }

    @Test(arguments: [
        (deck: "2Or■ 3Dg■ 2Or▥ 3Or▥ 2Sr▥ 2Dp▥ 3Op▥ 2Dg□ 3Dg□ 2Og□ 3Sg□ 2Op□", expect: []),
        (deck: "2Og■ 3Op■ 1Dr▥ 3Og▥ 3Dp▥ 3Dr□ 2Dg□ 3Dg□ 1Sg□ 3Sg□ 1Sp□ 2Sp□", expect: []),
        (deck: "2Dr■ 3Dg■ 2Dp■ 1Op■ 1Sp■ 2Og▥ 1Sg▥ 3Op▥ 1Sp▥ 1Dr□ 2Dr□ 1Dg□", expect: ["1Op■ 1Sg▥ 1Dr□"]),
        (deck: "2Dr■ 3Dr■ 1Or■ 2Or■ 2Dg■ 3Dg■ 3Sr▥ 3Dg▥ 1Sg▥ 3Sr□ 2Dg□ 2Op□", expect: ["3Dr■ 1Sg▥ 2Op□"]),
        (deck: "3Or■ 3Sg■ 2Dp■ 2Op■ 2Sp■ 3Sr▥ 3Dg▥ 3Og▥ 1Sp▥ 2Dr□ 2Or□ 1Dp□", expect: ["2Dp■ 2Op■ 2Sp■"]),
        (deck: "1Dg■ 3Og■ 1Sg■ 1Sp■ 3Or▥ 2Op▥ 3Op▥ 1Sp▥ 1Og□ 2Sg□ 3Op□ 3Sp□", expect: ["3Og■ 3Or▥ 3Op□"]),
        (deck: "3Og■ 1Sg■ 3Dp■ 1Op■ 2Sr▥ 3Sr▥ 1Op▥ 2Sp▥ 3Dr□ 2Sr□ 1Op□ 1Sp□", expect: ["3Dp■ 2Sp▥ 1Op□", "1Op■ 1Op▥ 1Op□"]),
        (deck: "2Dr■ 1Or■ 3Sr■ 2Dg■ 3Op■ 2Sp■ 2Or▥ 1Sp▥ 1Dr□ 1Sr□ 1Sg□ 2Op□", expect: ["2Dr■ 1Or■ 3Sr■", "3Sr■ 2Or▥ 1Dr□"]),
        (deck: "1Or■ 2Or■ 1Sr▥ 3Op▥ 1Sp▥ 2Sp▥ 2Dr□ 3Sr□ 2Og□ 3Og□ 2Sg□ 3Dp□", expect: ["3Sr□ 3Og□ 3Dp□", "1Or■ 3Op▥ 2Og□"]),
        (deck: "3Sr■ 1Og■ 3Og■ 1Sg■ 3Sg■ 1Op■ 3Dr▥ 2Sp▥ 1Sr□ 1Dg□ 1Og□ 3Sp□", expect: ["3Og■ 3Dr▥ 3Sp□", "3Sg■ 2Sp▥ 1Sr□"]),
        (deck: "2Dr■ 3Op■ 3Sp■ 3Sr▥ 1Og▥ 2Og▥ 1Dp▥ 1Dr□ 3Dr□ 2Sg□ 2Dp□ 3Dp□", expect: ["3Sr▥ 2Og▥ 1Dp▥", "3Sp■ 2Og▥ 1Dr□"]),
        (deck: "2Dr■ 2Or■ 1Og■ 3Og■ 3Dr▥ 1Or▥ 1Dg▥ 2Sg▥ 3Dp▥ 2Sp▥ 2Dp□ 1Sp□", expect: ["2Or■ 2Sg▥ 2Dp□", "1Or▥ 2Sg▥ 3Dp▥"]),
        (deck: "2Dr▥ 1Sr▥ 1Dg▥ 1Og▥ 3Og▥ 1Sp▥ 3Dr□ 1Or□ 2Or□ 3Or□ 2Og□ 1Sg□", expect: ["1Or□ 2Or□ 3Or□", "2Dr▥ 3Og▥ 1Sp▥"]),
        (deck: "3Or■ 2Dg■ 1Sg■ 2Sp■ 3Sp■ 2Dr▥ 3Dp▥ 3Sp▥ 1Dg□ 1Og□ 3Sg□ 2Sp□", expect: ["3Or■ 3Dp▥ 3Sg□", "3Sp■ 2Dr▥ 1Og□"]),
        (deck: "3Dr■ 3Sr■ 1Og■ 1Sp■ 2Sp■ 3Dr▥ 3Or▥ 1Sg▥ 2Dp▥ 1Sg□ 3Dp□ 1Sp□", expect: ["3Dr■ 1Og■ 2Sp■", "3Or▥ 1Sg▥ 2Dp▥"]),
        (deck: "1Dr■ 3Or■ 1Sr■ 2Sr■ 3Dg■ 2Sg■ 2Op■ 1Dr▥ 1Og▥ 3Dr□ 3Sr□ 1Dg□", expect: ["1Dr■ 3Or■ 2Sr■", "1Sr■ 3Dg■ 2Op■"]),
        (deck: "3Dr■ 1Or■ 3Sr■ 1Og■ 2Op■ 3Op■ 3Dg▥ 1Sg▥ 1Sp▥ 2Sr□ 1Sg□ 2Sg□", expect: ["1Og■ 3Dg▥ 2Sg□", "3Sr■ 1Sp▥ 2Sg□"]),
        (deck: "2Dr■ 3Or■ 1Sg■ 3Sr▥ 1Sg▥ 2Dp▥ 3Op▥ 1Sp▥ 3Sr□ 1Og□ 2Sg□ 3Op□", expect: ["2Dp▥ 3Op▥ 1Sp▥", "2Dr■ 1Sg▥ 3Op□"]),
        (deck: "1Dr■ 1Sr■ 1Dp■ 3Op■ 2Or▥ 1Dg▥ 2Dg▥ 1Dp▥ 1Op▥ 3Dg□ 1Dp□ 2Op□", expect: ["1Dp■ 1Dp▥ 1Dp□", "1Dr■ 1Dg▥ 1Dp□", "3Op■ 1Op▥ 2Op□"]),
        (deck: "1Sr■ 3Sr■ 2Op■ 2Sg▥ 1Dp▥ 1Sp▥ 2Sp▥ 3Dr□ 1Sr□ 2Og□ 3Dp□ 3Op□", expect: ["2Op■ 1Sp▥ 3Dp□", "1Sr□ 2Og□ 3Dp□", "3Sr■ 1Dp▥ 2Og□"]),
        (deck: "2Dr■ 2Sr■ 3Sg■ 1Dp■ 3Dp■ 2Dr▥ 3Dg▥ 2Og▥ 1Sg▥ 1Sp▥ 1Or□ 2Sr□", expect: ["1Dp■ 1Sg▥ 1Or□", "3Sg■ 1Sp▥ 2Sr□", "3Dg▥ 2Og▥ 1Sg▥"]),
        (deck: "3Dr■ 1Og■ 2Sg■ 2Dp■ 3Dr▥ 2Or▥ 2Og▥ 1Or□ 2Sr□ 3Dp□ 3Op□ 1Sp□", expect: ["3Dr■ 2Og▥ 1Sp□", "2Dp■ 2Og▥ 2Sr□", "1Og■ 2Or▥ 3Op□"]),
        (deck: "1Or■ 3Sr■ 1Dg■ 2Og■ 2Sg■ 1Sp■ 2Sg▥ 1Sp▥ 2Dr□ 2Or□ 3Or□ 3Sr□", expect: ["1Sp■ 2Sg▥ 3Sr□", "3Sr■ 2Sg■ 1Sp■", "1Or■ 1Dg■ 1Sp■", "2Sg■ 1Sp▥ 3Sr□"]),
        (deck: "3Sr■ 2Dg■ 2Sp■ 1Dr▥ 3Dr▥ 2Sr▥ 3Og▥ 3Sp▥ 1Or□ 2Og□ 2Sg□ 2Op□", expect: ["2Dg■ 2Sr▥ 2Op□", "3Dr▥ 3Og▥ 3Sp▥", "2Sp■ 2Sr▥ 2Sg□", "2Dg■ 3Sp▥ 1Or□"]),
        (deck: "1Or■ 3Or■ 2Sg■ 1Dr▥ 3Or▥ 3Dg▥ 2Og▥ 1Sg▥ 2Op▥ 1Sr□ 2Dp□ 1Op□", expect: ["3Or■ 1Sg▥ 2Dp□", "1Or■ 1Dr▥ 1Sr□", "3Or■ 2Og▥ 1Op□", "3Dg▥ 2Og▥ 1Sg▥"]),
        (deck: "3Sr■ 3Og■ 1Op■ 2Op■ 3Op■ 3Dr▥ 2Dg▥ 3Og▥ 1Sg▥ 3Sg▥ 1Dr□ 1Og□", expect: ["1Op■ 2Op■ 3Op■", "2Dg▥ 3Og▥ 1Sg▥", "1Op■ 1Sg▥ 1Dr□", "2Op■ 3Sg▥ 1Dr□"]),
        (deck: "1Dp■ 2Dp■ 1Dr▥ 2Sr▥ 3Sr▥ 2Dg▥ 3Dp▥ 2Sr□ 1Dg□ 1Sg□ 3Op□ 3Sp□", expect: ["1Dr▥ 2Dg▥ 3Dp▥", "1Dp■ 1Dr▥ 1Dg□", "2Sr□ 1Dg□ 3Op□", "2Sr□ 1Sg□ 3Sp□"]),
        (deck: "1Dg■ 2Dp▥ 2Dg■ 3Sg□ 2Sg▥ 2Sp■ 2Sp□ 3Sp■ 2Dr▥ 1Dg▥ 3Dr■ 1Or▥ 2Sg□ 1Sr■ 3Sp▥", expect: ["3Sp▥ 1Sr■ 2Sg□"]),
    ] as [(CardSet, [CardSet])])
    func findSets(deck: CardSet, expect: [CardSet]) {
        let result = SetSolver.findSets(cards: deck.cards)
        let expectedResult = Set(expect.map { $0.cards })
        #expect(result == expectedResult)
    }

    @Test(.disabled())
    func makeSomeSets() {
        for _ in 1...10 {
            let deck = Set(Card.allCases.shuffled().prefix(12))
            let results = SetSolver.findSets(cards: deck)
            print("(deck: \"\(CardSet(deck))\", expect: \(results.map { "\(CardSet($0))" })),")
        }
    }
}

/// Helper type for concise test data
struct CardSet: ExpressibleByStringLiteral, CustomStringConvertible {
    var cards: Set<Card>
    init(_ cards: some Sequence<Card>) { self.cards = Set(cards) }
    init(stringLiteral value: StringLiteralType) {
        cards = Set(value.split(separator: " ").map { .init(String($0))! })
    }
    var description: String { cards.sorted().map { $0.notation }.joined(separator: " ") }
}
