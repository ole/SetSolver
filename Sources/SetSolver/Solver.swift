import Algorithms

public func findSets(cards: Set<Card>) -> Set<Set<Card>> {
    guard cards.count >= 3 else {
        return []
    }
    var sets: Set<Set<Card>> = []
    let pairs = cards.combinations(ofCount: 2)
    for pair in pairs {
        let candidate = Card.matchingCard(for: pair[0], and: pair[1])
        if cards.contains(candidate) {
            sets.insert([pair[0], pair[1], candidate])
        }
    }
    return sets
}
