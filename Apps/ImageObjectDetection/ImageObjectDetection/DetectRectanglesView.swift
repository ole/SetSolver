import OSLog
import SwiftUI
import SetVision
import Vision

private let logger = Logger(subsystem: "DetectRectanglesView", category: "App")

private let sampleRectangles: [RectangleObservation] = [
    .init(
        topLeft: .init(x: 0.25, y: 0.1),
        topRight: .init(x: 0.6, y: 0.15),
        bottomRight: .init(x: 0.65, y: 0.5),
        bottomLeft: .init(x: 0.3, y: 0.45)
    ),
]

struct DetectRectanglesView: View {
    enum DetectionState {
        case running
        case finished([RectangleObservation])
        case failed(any Error)
    }

    var image: Image
    var imageURL: URL

    @State private var state: DetectionState = .finished([])
    // The minimum size of the rectangle to be detected,
    // as a proportion of the smallest dimension of the image.
    // This is important to tweak to make sure all cards are detected.
    @State private var minimumRectangleSize: Float = 0.1

    var body: some View {
        VStack {
            switch state {
            case .running:
                HStack {
                    Text("Detecting rectangles…")
                    ProgressView()
                }
            case .finished(let rectangles):
                HStack {
                    Text("Detected \(rectangles.count) rectangles")
                    Button("Retry") {}
                }
            case .failed(let error):
                HStack {
                    Text("Error: \(error.localizedDescription)")
                    Button("Retry") {}
                }
            }

            image
                .resizable()
                .scaledToFit()
                .overlay {
                    if case .finished(let rectangles) = state {
                        ForEach(rectangles, id: \.self) { rect in
                            UnitPointPolygon(points: [
                                UnitPoint(rect.topLeft),
                                UnitPoint(rect.topRight),
                                UnitPoint(rect.bottomRight),
                                UnitPoint(rect.bottomLeft),
                            ])
                            .stroke(.red, lineWidth: 2)
                        }
                    }
                }

            Slider(value: $minimumRectangleSize, in: 0.05...0.95, step: 0.05) {
                Text("Min rect size: \(minimumRectangleSize, format: .number.precision(.fractionLength(2)))")
            }
        }
        .padding()
        .task(id: minimumRectangleSize) {
            state = .running
            do {
                logger.debug("Starting rectangle detection")
                let rectangles = try await detectRectangles(
                    in: imageURL,
                    minimumSize: minimumRectangleSize
                )
                try Task.checkCancellation()
                self.state = .finished(rectangles)
            } catch is CancellationError {
                logger.warning("Rectangle detection cancelled.")
            } catch {
                logger.warning("Rectangle detection failed: \(error)")
                self.state = .failed(error)
            }
        }
    }
}

#Preview {
    if let imageURL = Bundle.main.url(forResource: "set-cards-4.jpeg", withExtension: nil),
        let cgImageSource = CGImageSourceCreateWithURL(imageURL as CFURL, nil),
                let cgImage: CGImage = CGImageSourceCreateImageAtIndex(cgImageSource, 0, nil)
    {
        let image = Image(cgImage, scale: 1, label: Text(""))
        DetectRectanglesView(
            image: image,
            imageURL: imageURL
        )
    } else {
        Text("Unable to load image.")
    }

}
