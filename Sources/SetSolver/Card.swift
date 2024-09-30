/// A single card in the card game
/// [Set](https://en.wikipedia.org/wiki/Set_%28card_game%29).
///
/// Each card has four properties:
///
/// - The number of objects on the card (1, 2, or 3)
/// - The color of the objects (red, green, purple)
/// - The shading of the objects (solid fill, striped, outlined)
/// - The type or "symbol" of object (diamond, oval, squiggle)
public struct Card: Hashable, CaseIterable, Sendable {
    public var color: Color
    public var number: Number
    public var shading: Shading
    public var symbol: Symbol

    public init(color: Color, number: Number, shading: Shading, symbol: Symbol) {
        self.color = color
        self.number = number
        self.shading = shading
        self.symbol = symbol
    }

    public init(_ color: Color, _ number: Number, _ shading: Shading, _ symbol: Symbol) {
        self.init(color: color, number: number, shading: shading, symbol: symbol)
    }

    public static var allCases: [Card] {
        Color.allCases.flatMap { color in
            Number.allCases.flatMap { number in
                Shading.allCases.flatMap { shading in
                    Symbol.allCases.map { symbol in
                        Card(color: color, number: number, shading: shading, symbol: symbol)
                    }
                }
            }
        }
    }

    public var notation: String {
        "\(color.notation)\(number.notation)\(shading.notation)\(symbol.notation)"
    }

    /// Returns the card that forms a set with the two given cards.
    ///
    /// For any two cards there exists exactly one matching card to form a set.
    public static func matchingCard(for a: Card, and b: Card) -> Card {
        let color = Color.matchingItem(for: a.color, and: b.color)
        let number = Number.matchingItem(for: a.number, and: b.number)
        let shading = Shading.matchingItem(for: a.shading, and: b.shading)
        let symbol = Symbol.matchingItem(for: a.symbol, and: b.symbol)
        return Card(color: color, number: number, shading: shading, symbol: symbol)
    }
}

public enum Color: UInt8, CaseIterable, Sendable {
    // Each case is represented by a single bit.
    // This isn't the most compact representation, but it's convenient for calculations.
    case red = 1
    case green = 2
    case purple = 4

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

public enum Number: UInt8, CaseIterable, Sendable {
    // Each case is represented by a single bit.
    // This isn't the most compact representation, but it's convenient for calculations.
    case one = 1
    case two = 2
    case three = 4

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

public enum Shading: UInt8, CaseIterable, Sendable {
    // Each case is represented by a single bit.
    // This isn't the most compact representation, but it's convenient for calculations.
    case solid = 1
    case striped = 2
    case outlined = 4

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

public enum Symbol: UInt8, CaseIterable, Sendable {
    // Each case is represented by a single bit.
    // This isn't the most compact representation, but it's convenient for calculations.
    case diamond = 1
    case oval = 2
    case squiggle = 4

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
