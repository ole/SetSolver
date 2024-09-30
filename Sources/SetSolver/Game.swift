/// The game state of a running game for the card game
/// [Set](https://en.wikipedia.org/wiki/Set_%28card_game%29).
///
/// Models a one-player game where the goal is to find valid sets until the card
/// deck is exhausted. This does not model a multi-player game where scores are
/// kept by player.
public struct Game: Hashable, Sendable {
    public var remainingCards: [Card]
    public var openCards: Set<Card> = []
    public var moves: [Move] = []

    public init() {
        self.remainingCards = Card.allCases
    }

    public var foundSets: [Set<Card>] {
        moves.compactMap(\.foundSet)
    }

    /// Starts a new game. This shuffles the deck.
    ///
    /// - TODO: Add the ability to start the game with a deterministic card
    ///   order in the deck, for reproducible games.
    public mutating func start() {
        remainingCards = Card.allCases.shuffled()
        openCards = Set(remainingCards.suffix(12))
        remainingCards.removeLast(12)
        moves = []
    }

    /// Executes a single move.
    ///
    /// - Returns: The executed move, or `nil` if there are no moves left
    ///   (game over).
    public mutating func makeMove() -> Move? {
        let foundSet = findSets(cards: openCards).first
        let isGameOver = foundSet == nil && remainingCards.isEmpty
        guard !isGameOver else {
            return nil
        }

        var move = Move(foundSet: foundSet, newCards: nil)
        defer {
            moves.append(move)
        }
        if let foundSet {
            openCards.formSymmetricDifference(foundSet)
        }

        // Deal 3 new cards
        let didNotFindSet = foundSet == nil
        if !remainingCards.isEmpty {
            if openCards.count <= 9 || didNotFindSet {
                let newCards = Set(remainingCards.suffix(3))
                move.newCards = newCards
                openCards.formUnion(newCards)
                remainingCards.removeLast(newCards.count)
            }
        }

        return move
    }
}

public struct Move: Hashable, Sendable {
    public var foundSet: Optional<Set<Card>>
    public var newCards: Optional<Set<Card>>

    public init(foundSet: Set<Card>?, newCards: Set<Card>?) {
        self.foundSet = foundSet
        self.newCards = newCards
    }
}
