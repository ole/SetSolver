import SwiftUI
import Vision

struct UnitPointPolygon: Shape {
    var points: [UnitPoint]

    nonisolated func path(in rect: CGRect) -> Path {
        Path { p in
            guard let first = points.first else { return }
            p.move(to: rect.position(first))
            for unitPoint in points.dropFirst() {
                p.addLine(to: rect.position(unitPoint))
            }
            p.closeSubpath()
        }
    }
}

extension CGRect {
    func position(_ unitPoint: UnitPoint) -> CGPoint {
        CGPoint(
            x: minX + unitPoint.x * width,
            y: minY + unitPoint.y * height
        )
    }
}
