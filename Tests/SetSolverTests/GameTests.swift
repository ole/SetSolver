import SetSolver
import XCTest

final class GameTests: XCTestCase {
    func test_play() {
        var game = Game()
        game.start()
        while game.makeMove() {}
        print("=========")
        print("Game over")
        print("Found \(game.foundSets.count) sets")
    }
}
