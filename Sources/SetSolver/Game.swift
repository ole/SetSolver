public struct Game {
    public var remainingCards: [Card]
    public var openCards: Set<Card> = []
    public var foundSets: [Set<Card>] = []
    public var moveNumber: Int = 1

    public init() {
        self.remainingCards = Card.allCases
    }

    public mutating func start() {
        remainingCards = Card.allCases.shuffled()
        openCards = Set(remainingCards.suffix(12))
        remainingCards.removeLast(12)
        foundSets = []
        moveNumber = 1
    }

    public mutating func makeMove() -> Bool {
        print("Move \(moveNumber)")
        defer {
            moveNumber += 1
        }

        print("Open cards:", openCards.map(\.notation).joined(separator: ", "))
        let sets = findSets(cards: openCards)
        if let foundSet = sets.first {
            print("Found set \(foundSet.map(\.notation).joined(separator: ", "))")
            foundSets.append(foundSet)
            openCards.formSymmetricDifference(foundSet)
        } else {
            print("No set found")
            if remainingCards.isEmpty {
                // Game over
                return false
            }
        }
        // Deal 3 new cards
        let didNotFindSet = sets.isEmpty
        if !remainingCards.isEmpty {
            if openCards.count <= 9 || didNotFindSet {
                let newCards = remainingCards.suffix(3)
                print("Dealing new cards: \(newCards.map(\.notation).joined(separator: ", "))")
                openCards.formUnion(newCards)
                remainingCards.removeLast(newCards.count)
            } else {
                print("We already have \(openCards.count) open cards, not dealing new cards")
            }
        }
        print("---")
        return true
    }
}
