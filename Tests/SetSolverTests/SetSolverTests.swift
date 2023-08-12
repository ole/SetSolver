import XCTest
import SetSolver

final class SetSolverTests: XCTestCase {
    func test_Card_allCases() {
        let allCards = Card.allCases
        XCTAssertEqual(allCards.count, 81)
        let uniqueCards = Set(allCards)
        XCTAssertEqual(uniqueCards.count, 81)

        print(allCards.map(\.notation).joined(separator: " "))
    }
}
