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
    var image: Image
    var imageURL: URL

    @State private var rectangles: [RectangleObservation] = []

    var body: some View {
        VStack {
            Text("Detected \(rectangles.count) rectangles")
            image
                .resizable()
                .scaledToFit()
                .overlay {
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
        .padding()
        .task(id: imageURL) {
            do {
                self.rectangles = try await detectRectangles(in: imageURL)
            } catch {
                logger.warning("Rectangle detection failed: \(error)")
            }
        }
    }
}

#Preview {
    if let imageURL = Bundle.main.url(forResource: "set-cards-3.jpeg", withExtension: nil),
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
