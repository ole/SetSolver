/// A single card in the card game
/// [Set](https://en.wikipedia.org/wiki/Set_%28card_game%29).
///
/// Each card has four properties:
///
/// - The number of objects on the card (1, 2, or 3)
/// - The type or "symbol" of object (diamond, oval, squiggle)
/// - The color of the objects (red, green, purple)
/// - The shading of the objects (solid fill, striped, outlined)
public struct Card: Hashable, Comparable, CaseIterable, Sendable, CustomDebugStringConvertible {
    // IMPORTANT: If you add a stored property, you MUST update `static func <`.
    public var number: Number
    public var symbol: Symbol
    public var color: Color
    public var shading: Shading

    public init(number: Number, symbol: Symbol, color: Color, shading: Shading) {
        self.number = number
        self.symbol = symbol
        self.color = color
        self.shading = shading
    }

    public init( _ number: Number, _ symbol: Symbol, _ color: Color, _ shading: Shading) {
        self.init(number: number, symbol: symbol, color: color, shading: shading)
    }

    public static var allCases: [Card] {
        Number.allCases.flatMap { number in
            Symbol.allCases.flatMap { symbol in
                Color.allCases.flatMap { color in
                    Shading.allCases.map { shading in
                        Card(number: number, symbol: symbol, color: color, shading: shading)
                    }
                }
            }
        }
    }

    public static func < (lhs: Self, rhs: Self) -> Bool {
        return (lhs.number, lhs.symbol, lhs.color, lhs.shading)
             < (rhs.number, rhs.symbol, rhs.color, rhs.shading)
    }

    public var debugDescription: String {
        notation
    }

    public var notation: String {
        "\(number.notation)\(symbol.notation)\(color.notation)\(shading.notation)"
    }

    /// Returns the card that forms a set with the two given cards.
    ///
    /// For any two cards there exists exactly one matching card to form a set.
    public static func matchingCard(for a: Card, and b: Card) -> Card {
        let color = Color.matchingItem(for: a.color, and: b.color)
        let number = Number.matchingItem(for: a.number, and: b.number)
        let shading = Shading.matchingItem(for: a.shading, and: b.shading)
        let symbol = Symbol.matchingItem(for: a.symbol, and: b.symbol)
        return Card(number: number, symbol: symbol, color: color, shading: shading)
    }
}

public enum Color: UInt8, Comparable, CaseIterable, Sendable {
    // Each case is represented by a single bit.
    // This isn't the most compact representation, but it's convenient for calculations.
    case red = 1
    case green = 2
    case purple = 4

    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue < rhs.rawValue
    }

    public var notation: String {
        switch self {
        case .red: "r"
        case .green: "g"
        case .purple: "p"
        }
    }

    public static func matchingItem(for a: Self, and b: Self) -> Self {
        if a == b {
            return a
        } else {
            // a XOR b sets the bits that represent a and b.
            // Negating selects the bit that represents the missing case.
            let c = ~(a.rawValue ^ b.rawValue) & 0b111
            return Self(rawValue: c)!
        }
    }
}

public enum Number: UInt8, Comparable, CaseIterable, Sendable {
    // Each case is represented by a single bit.
    // This isn't the most compact representation, but it's convenient for calculations.
    case one = 1
    case two = 2
    case three = 4

    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue < rhs.rawValue
    }

    public var notation: String {
        switch self {
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        }
    }

    public static func matchingItem(for a: Self, and b: Self) -> Self {
        if a == b {
            return a
        } else {
            // a XOR b sets the bits that represent a and b.
            // Negating selects the bit that represents the missing case.
            let c = ~(a.rawValue ^ b.rawValue) & 0b111
            return Self(rawValue: c)!
        }
    }
}

public enum Shading: UInt8, Comparable, CaseIterable, Sendable {
    // Each case is represented by a single bit.
    // This isn't the most compact representation, but it's convenient for calculations.
    case solid = 1
    case striped = 2
    case outlined = 4

    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue < rhs.rawValue
    }

    public var notation: String {
        switch self {
        case .solid: "■" // U+25A0 BLACK SQUARE
        case .striped: "▥" // U+25A5 SQUARE WITH VERTICAL FILL
        case .outlined: "□" // U+25A1 WHITE SQUARE
        }
    }

    public static func matchingItem(for a: Self, and b: Self) -> Self {
        if a == b {
            return a
        } else {
            // a XOR b sets the bits that represent a and b.
            // Negating selects the bit that represents the missing case.
            let c = ~(a.rawValue ^ b.rawValue) & 0b111
            return Self(rawValue: c)!
        }
    }
}

public enum Symbol: UInt8, Comparable, CaseIterable, Sendable {
    // Each case is represented by a single bit.
    // This isn't the most compact representation, but it's convenient for calculations.
    case diamond = 1
    case oval = 2
    case squiggle = 4

    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue < rhs.rawValue
    }

    public var notation: String {
        switch self {
        case .diamond: "D"
        case .oval: "O"
        case .squiggle: "S"
        }
    }

    public static func matchingItem(for a: Self, and b: Self) -> Self {
        if a == b {
            return a
        } else {
            // a XOR b sets the bits that represent a and b.
            // Negating selects the bit that represents the missing case.
            let c = ~(a.rawValue ^ b.rawValue) & 0b111
            return Self(rawValue: c)!
        }
    }
}
