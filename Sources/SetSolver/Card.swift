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
    private let bits: UInt16

    public var number:  Number  { .init(bits: bits) }
    public var symbol:  Symbol  { .init(bits: bits) }
    public var color:   Color   { .init(bits: bits) }
    public var shading: Shading { .init(bits: bits) }

    public init(number: Number, symbol: Symbol, color: Color, shading: Shading) {
        self.bits = number.bits | symbol.bits | color.bits | shading.bits
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
        return lhs.rawValue < rhs.rawValue
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

extension Card: RawRepresentable, Codable {
    public var rawValue: UInt16 { bits }

    public init?(rawValue: UInt16) {
        guard rawValue & ~0x777 == 0 else { return nil }
        self.bits = rawValue
    }
}

public enum Color: UInt8, CardProperty, CaseIterable, Sendable {
    // Each case is represented by a single bit.
    // This isn't the most compact representation, but it's convenient for calculations.
    case red    = 0b001
    case green  = 0b010
    case purple = 0b100
    static var bitOffset: Int { 8 }

    public var notation: String {
        switch self {
        case .red: "r"
        case .green: "g"
        case .purple: "p"
        }
    }
}

public enum Number: UInt8, CardProperty, CaseIterable, Sendable {
    // Each case is represented by a single bit.
    // This isn't the most compact representation, but it's convenient for calculations.
    case one   = 0b001
    case two   = 0b010
    case three = 0b100
    static var bitOffset: Int { 0 }

    public var notation: String {
        switch self {
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        }
    }
}

public enum Shading: UInt8, CardProperty, CaseIterable, Sendable {
    // Each case is represented by a single bit.
    // This isn't the most compact representation, but it's convenient for calculations.
    case solid    = 0b001
    case striped  = 0b010
    case outlined = 0b100
    static var bitOffset: Int { 12 }

    public var notation: String {
        switch self {
        case .solid: "■" // U+25A0 BLACK SQUARE
        case .striped: "▥" // U+25A5 SQUARE WITH VERTICAL FILL
        case .outlined: "□" // U+25A1 WHITE SQUARE
        }
    }
}

public enum Symbol: UInt8, CardProperty, CaseIterable, Sendable {
    // Each case is represented by a single bit.
    // This isn't the most compact representation, but it's convenient for calculations.
    case diamond  = 0b001
    case oval     = 0b010
    case squiggle = 0b100
    static var bitOffset: Int { 4 }

    public var notation: String {
        switch self {
        case .diamond: "D"
        case .oval: "O"
        case .squiggle: "S"
        }
    }
}

protocol CardProperty: RawRepresentable where RawValue == UInt8 {
    static var bitOffset: Int { get }
}

extension CardProperty {
    fileprivate init(bits: UInt16) {
        self.init(rawValue: UInt8((bits >> Self.bitOffset) & 0b111))!
    }

    fileprivate var bits: UInt16 { UInt16(rawValue) << Self.bitOffset }

    fileprivate static func matchingItem(for a: Self, and b: Self) -> Self {
        guard a != b else { return a }
        return Self(rawValue: (a.rawValue | b.rawValue) ^ 0b111)!
    }
}
