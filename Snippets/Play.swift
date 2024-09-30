// Plays a game of Set.

import SetSolver

var game = Game()
game.start()

print("Starting game with shuffled deck\n")
print("Remaining cards | \(game.openCards.count) open, \(game.remainingCards.count) in deck")
print("————————————————————————————————————————————————————————————————————")

while true {
    print("Move no.        | \(game.moves.count + 1)")
    print("Open cards      | \(game.openCards.map(\.notation).joined(separator: " "))")
    guard let move = game.makeMove() else {
        if !game.openCards.isEmpty {
            print("No sets left, game over")
        } else {
            print("No cards left")
        }
        break
    }

    if let foundSet = move.foundSet {
        print("Found set       | \(foundSet.map(\.notation).joined(separator: " "))")
    } else {
        print("Found set       | (none)")
    }

    if let newCards = move.newCards {
        print("New cards       | \(newCards.map(\.notation).joined(separator: " "))")
    } else if game.remainingCards.count > 12 {
        print("New cards       | (none, we already have \(game.openCards.count) open cards)")
    }
    print("Remaining cards | \(game.openCards.count) open, \(game.remainingCards.count) in deck")
    print("————————————————————————————————————————————————————————————————————")
}
