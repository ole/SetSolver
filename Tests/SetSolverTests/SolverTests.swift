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
}
