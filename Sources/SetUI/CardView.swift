import SetSolver
import SwiftUI

struct CardView: View {
    var card: Card

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(.background)
            RoundedRectangle(cornerRadius: 16)
                .stroke(.primary)
            VStack(spacing: 20) {
                ForEach(Array(0 ..< card.number.count), id: \.self) { _ in
                    card.view
                        .aspectRatio(3, contentMode: .fit)
                        .foregroundStyle(.tint)
                }
            }
            .tint(card.color.swiftUIColor)
            .padding()
        }
        .aspectRatio(9/16, contentMode: .fit)
    }
}

#Preview {
    HStack {
        CardView(card: Card(color: .red, number: .one, shading: .solid, symbol: .squiggle))
        CardView(card: Card(color: .green, number: .two, shading: .striped, symbol: .diamond))
        CardView(card: Card(color: .purple, number: .three, shading: .outlined, symbol: .oval))
    }
    .padding()
}

extension SetSolver.Number {
    var count: Int {
        switch self {
        case .one: 1
        case .two: 2
        case .three: 3
        }
    }
}

extension SetSolver.Color {
    var swiftUIColor: SwiftUI.Color {
        switch self {
        case .red: .red
        case .green: .green
        case .purple: .purple
        }
    }
}

extension SetSolver.Card {
    @ViewBuilder var view: some View {
        let shape = SetSymbolShape(symbol: symbol)
        switch shading {
        case .solid:
            shape.fill()
        case .striped:
            ZStack {
                StripedShape(stripeWidth: 2, spacing: 4)
                    .clipShape(shape)
                shape.stroke(lineWidth: 4)
            }
        case .outlined:
            shape.stroke(lineWidth: 4)
        }
    }
}

struct SetSymbolShape: InsettableShape {
    var symbol: SetSolver.Symbol
    var inset: CGFloat = 0

    func path(in rect: CGRect) -> Path {
        let r = rect.insetBy(dx: inset, dy: inset)
        switch symbol {
        case .diamond:
            return Path { p in
                p.move(to: CGPoint(x: r.midX, y: r.minY))
                p.addLine(to: CGPoint(x: r.maxX, y: r.midY))
                p.addLine(to: CGPoint(x: r.midX, y: r.maxY))
                p.addLine(to: CGPoint(x: r.minX, y: r.midY))
                p.closeSubpath()
            }
        case .oval:
            return Path(roundedRect: r, cornerRadius: min(r.width, r.height) / 2)
        case .squiggle:
            let dx = r.width/8
            let dy = r.height/8
            return Path { p in
                p.move(to: CGPoint(x: r.minX+dx, y: r.maxY))
                p.addCurve(
                    to: CGPoint(x: r.midX, y: r.minY+dy),
                    control1: CGPoint(x: r.minX, y: r.midY),
                    control2: CGPoint(x: r.minX+2*dx, y: r.minY-dy)
                )
                p.addCurve(
                    to: CGPoint(x: r.maxX-dx, y: r.minY),
                    control1: CGPoint(x: r.midX+2*dx, y: r.minY+3*dy),
                    control2: CGPoint(x: r.midX+2*dx, y: r.minY)
                )
                p.addCurve(
                    to: CGPoint(x: r.midX, y: r.maxY-dy),
                    control1: CGPoint(x: r.maxX, y: r.midY),
                    control2: CGPoint(x: r.maxX-2*dx, y: r.maxY+dy)
                )
                p.addCurve(
                    to: CGPoint(x: r.minX+dx, y: r.maxY),
                    control1: CGPoint(x: r.midX-2*dx, y: r.maxY-3*dy),
                    control2: CGPoint(x: r.midX-2*dx, y: r.maxY)
                )
                p.closeSubpath()
            }
        }
    }

    func inset(by amount: CGFloat) -> Self {
        Self(symbol: symbol, inset: inset + amount)
    }
}

struct StripedShape: Shape {
    var stripeWidth: CGFloat = 4
    var spacing: CGFloat = 4

    func path(in rect: CGRect) -> Path {
        var p = Path()
        let xPositions = stride(from: rect.minX + spacing, through: rect.maxX, by: stripeWidth + spacing)
        for xPos in xPositions {
            p.addRect(CGRect(x: xPos, y: rect.minY, width: stripeWidth, height: rect.height))
        }
        return p
    }
}
