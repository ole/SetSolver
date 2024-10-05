import OSLog
import SwiftUI
import Vision

private let logger = Logger(subsystem: "RectangleObservationView", category: "App")

/// Visualizes the shape of a ``Vision/RectangleObservation``.
///
/// It's expected that you place this view in an ``overlay`` on top of the
/// source image of the detected rectangle. In any case, the view the overlay is
/// being applied to should have the same aspect ratio as the source image.
struct RectangleObservationView: View {
    var rect: RectangleObservation

    var body: some View {
        ZStack {
            RectangleObservationLayout(rect: rect) {
                // "Re-normalize" the normalized points of `rect` into the
                // rect's bounding box.
                //
                // The points `rect.topLeft`, `rect.topRight` etc. are
                // normalized to the size of the source image of the detected
                // rectangle. But `RectangleObservationLayout` has already
                // "shrunk" the current layout context to `rect.boundingBox`.
                //
                // So we need to re-interpret the normalized points as if they
                // used `rect.boundingBox` as their reference frame.
                let bounds = rect.boundingBox.verticallyFlipped().cgRect
                let topLeft = UnitPoint(
                    x: (rect.topLeft.x - bounds.minX) / bounds.width,
                    y: (1 - rect.topLeft.y - bounds.minY) / bounds.height
                )
                let bottomLeft = UnitPoint(
                    x: (rect.bottomLeft.x - bounds.minX) / bounds.width,
                    y: (1 - rect.bottomLeft.y - bounds.minY) / bounds.height
                )
                let topRight = UnitPoint(
                    x: (rect.topRight.x - bounds.minX) / bounds.width,
                    y: (1 - rect.topRight.y - bounds.minY) / bounds.height
                )
                let bottomRight = UnitPoint(
                    x: (rect.bottomRight.x - bounds.minX) / bounds.width,
                    y: (1 - rect.bottomRight.y - bounds.minY) / bounds.height
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

/// A layout that translates a normalized rectangle from Vision.framework
/// into a corresponding view size and position for SwiftUI.
///
/// For example, if the bounding box of the normalized input rect has its
/// left edge at 0.2 and a width of 0.6, the layout will propose a width of 60 %
/// of its parent to its subviews, and place the subviews at 20 % from the
/// parent view's left edge.
///
/// Note that ``Vision/NormalizedRect.boundingBox`` has its origin in the lower-
/// left corner, whereas SwiftUI has the origin at the top.
struct RectangleObservationLayout: Layout {
    var rect: RectangleObservation

    func sizeThatFits(
        proposal: ProposedViewSize,
        subviews: Subviews,
        cache: inout ()
    ) -> CGSize {
        // Report the proposed size back to our parent. I'd prefer reporting
        // the size we propose to our subviews instead (which will usually be
        // smaller), but then we can't freely position the subviews inside the
        // bigger bounding box because positioning is the responsibility of the
        // parent view.
        //
        // TODO: Perhaps we can better solve this by publishing custom alignment guides.
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
                at: bounds.origin.applying(
                    CGAffineTransform(translationX: cgRect.minX, y: cgRect.minY)
                ),
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
