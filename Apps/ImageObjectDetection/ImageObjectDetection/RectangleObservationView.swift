import OSLog
import SwiftUI
import Vision

private let logger = Logger(subsystem: "RectangleObservationView", category: "App")

struct RectangleObservationView: View {
    var rect: RectangleObservation

    var body: some View {
        ZStack {
            RectangleObservationLayout(rect: rect) {
                let cgRect = rect.boundingBox.verticallyFlipped().cgRect
                let topLeft = UnitPoint(
                    x: (rect.topLeft.x - cgRect.minX) / cgRect.width,
                    y: (1 - rect.topLeft.y - cgRect.minY) / cgRect.height
                )
                let bottomLeft = UnitPoint(
                    x: (rect.bottomLeft.x - cgRect.minX) / cgRect.width,
                    y: (1 - rect.bottomLeft.y - cgRect.minY) / cgRect.height
                )
                let topRight = UnitPoint(
                    x: (rect.topRight.x - cgRect.minX) / cgRect.width,
                    y: (1 - rect.topRight.y - cgRect.minY) / cgRect.height
                )
                let bottomRight = UnitPoint(
                    x: (rect.bottomRight.x - cgRect.minX) / cgRect.width,
                    y: (1 - rect.bottomRight.y - cgRect.minY) / cgRect.height
                )
                UnitPointPolygon(points: [
                    topLeft,
                    topRight,
                    bottomRight,
                    bottomLeft,
                ])
                .stroke(.red, lineWidth: 2)
                .overlay(alignment: .bottomLeading) {
                    Text("\(rect.confidence, format: .percent)")
                        .fixedSize()
                        .foregroundStyle(.white)
                        .padding(2)
                        .background(.red)
                        .alignmentGuide(.bottom) { dim in dim[.top] }
                }
            }
            .border(.pink, width: 2)
        }
    }
}

struct RectangleObservationLayout: Layout {
    var rect: RectangleObservation

    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        proposal.replacingUnspecifiedDimensions()
    }

    func placeSubviews(
        in bounds: CGRect,
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) {
        let cgRect = rect.boundingBox.toImageCoordinates(
            proposal.replacingUnspecifiedDimensions(),
            origin: .upperLeft
        )
        for subview in subviews {
            subview.place(
                at: bounds.origin.applying(.init(translationX: cgRect.minX, y: cgRect.minY)),
                anchor: .topLeading,
                proposal: ProposedViewSize(cgRect.size)
            )
        }
    }
}

#Preview {
    Rectangle()
        .fill(.blue.gradient)
        .aspectRatio(1, contentMode: .fit)
        .overlay {
            RectangleObservationView(rect: sampleRectangles[0])
        }
        .padding(50)
}
