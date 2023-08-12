/// Returns the card that forms a set with the two given cards.
/// For any two cards there exists one and only one matching card to form a set.
public func matchingCard(_ one: Card, _ two: Card) -> Card {
    
}

public struct Card: Hashable, CaseIterable {
    public var color: Color
    public var number: Number
    public var shading: Shading
    public var symbol: Symbol

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
        "\(number.notation)\(color.notation)\(shading.notation)\(symbol.notation)"
    }
}

public enum Color: CaseIterable {
    case red
    case green
    case purple

    public var notation: String {
        switch self {
        case .red: "r"
        case .green: "g"
        case .purple: "p"
        }
    }
}

public enum Number: CaseIterable {
    case one
    case two
    case three

    public var notation: String {
        switch self {
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        }
    }
}

public enum Shading: CaseIterable {
    case solid
    case striped
    case outlined

    public var notation: String {
        switch self {
        case .solid: "■" // U+25A0 BLACK SQUARE
        case .striped: "▤" // U+25A4 SQUARE WITH HORIZONTAL FILL
        case .outlined: "□" // U+25A1 WHITE SQUARE
        }
    }
}

public enum Symbol: CaseIterable {
    case diamond
    case oval
    case squiggle

    public var notation: String {
        switch self {
        case .diamond: "D"
        case .oval: "O"
        case .squiggle: "S"
        }
    }
}
