import OSLog
import SwiftUI
import SetVision
import Vision

private let logger = Logger(subsystem: "DetectRectanglesView", category: "App")

struct DetectRectanglesView: View {
    enum DetectionState {
        case running
        case finished([RectangleObservation])
        case failed(any Error)
    }

    var image: Image
    var imageURL: URL

    @State private var state: DetectionState = .finished([])
    @State private var requestCounter: Int = 1
    /// The minimum size of the rectangle to be detected,
    /// as a proportion of the smallest dimension of the image.
    /// This is important to tweak to make sure all cards are detected.
    @State private var minimumRectangleSize: Float = 0.1
    @State private var minimumConfidence: Float = 0.0

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
                    Button("Retry") { requestCounter += 1 }
                }
            case .failed(let error):
                HStack {
                    Text("Error: \(error.localizedDescription)")
                    Button("Retry") { requestCounter += 1 }
                }
            }

            image
                .resizable()
                .scaledToFit()
                .overlay {
                    if case .finished(let rectangles) = state {
                        ForEach(rectangles, id: \.self) { rect in
                            RectangleObservationView(rect: rect)
                        }
                    }
                }

            Slider(value: $minimumRectangleSize, in: 0.05...0.95, step: 0.05) {
                Text("Min rect size: \(minimumRectangleSize, format: .number.precision(.fractionLength(2)))")
            }
            Slider(value: $minimumConfidence, in: 0.0...1.0, step: 0.05) {
                Text("Min confidence: \(minimumConfidence, format: .number.precision(.fractionLength(2)))")
            }
        }
        .padding()
        .task(id: detectionRequest) {
            state = .running
            do {
                logger.debug("Starting rectangle detection for \(imageURL.lastPathComponent)")
                let rectangles = try await detectRectangles(
                    in: detectionRequest.imageURL,
                    minimumSize: detectionRequest.minimumSize,
                    minimumConfidence: detectionRequest.minimumConfidence
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

    private var detectionRequest: RectangleDetectionRequest {
        RectangleDetectionRequest(
            requestID: requestCounter,
            imageURL: imageURL,
            minimumSize: minimumRectangleSize,
            minimumConfidence: minimumConfidence
        )
    }
}

struct RectangleDetectionRequest: Equatable {
    var requestID: Int
    var imageURL: URL
    var minimumSize: Float
    var minimumConfidence: Float
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
