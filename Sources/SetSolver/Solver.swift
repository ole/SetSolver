import Algorithms

/// Finds all valid sets in the input cards.
///
/// - Parameter cards: The input cards. In a running Set game,
///   these are the cards that are lying face-up on the table.
/// - Returns: A Swift `Set` of valid sets in the input cards.
///
///   Properties:
///
///   - Each inner `Set` will consist of exactly 3 cards.
///   - Valid sets may overlap, i.e. a single card may be a member
///     of multiple sets in the result.
///
///   If no valid set is found, the result will be the empty `Set`.
///   If the input contains less than 3 cards, the result set will
///   always be empty.
///
/// - Complexity: O(n²), where n is the number of elements in `cards`.
///
/// Algorithm:
///
/// 1. Generate all possible 2-card pairs in `cards`. There are `((n - 1) × n) / 2`
///    such pairs. E.g. for n == 12, there are `(11 × 12) / 2 = 66` pairs.
///    Complexity: O(n²).
/// 2. For each pair, compute the unique card that makes a valid set.
///    Complexity: O(1).
/// 3. Check if the matching card is present in `cards`. If so, we have found a
///    set. Complexity: O(1).
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
