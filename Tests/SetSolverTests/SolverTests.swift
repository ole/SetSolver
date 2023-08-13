import SetSolver
import XCTest

final class SolverTests: XCTestCase {
    func test_findSets() {
        let red_1_out_dia = Card(.red,   .one,   .outlined, .diamond)
        let red_2_out_dia = Card(.red,   .two,   .outlined, .diamond)
        let red_3_out_dia = Card(.red,   .three, .outlined, .diamond)
        let gre_1_out_dia = Card(.green, .one,   .outlined, .diamond)
        let gre_2_sol_squ = Card(.green, .two,   .solid,    .squiggle)
        let gre_3_str_ova = Card(.green, .three, .striped,  .oval)
        let cards: Set<Card> = [
            red_1_out_dia, gre_1_out_dia, red_3_out_dia, red_2_out_dia, gre_2_sol_squ, gre_3_str_ova,
        ]
        let actual = findSets(cards: cards)
        let expected: Set<Set<Card>> = [
            [red_1_out_dia, red_2_out_dia, red_3_out_dia],
            [gre_1_out_dia, gre_2_sol_squ, gre_3_str_ova],
        ]
        let string = actual.map { set in
            set.map(\.notation)
                .joined(separator: ",")
        }.joined(separator: "\n")
        print(string)
        XCTAssertEqual(actual, expected)
    }
}
