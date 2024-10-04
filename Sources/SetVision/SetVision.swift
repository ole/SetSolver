import Vision

/// - Parameter minimumSize: The minimum size of the rectangle to be detected,
///   as a proportion of the smallest dimension of the image.
public func detectRectangles(in imageURL: URL, minimumSize: Float) async throws -> [RectangleObservation] {
    var request = DetectRectanglesRequest(.revision1)
    // A full Set deck has 81 cards
    request.maximumObservations = 81
    request.minimumSize = minimumSize
    let observations = try await request.perform(on: imageURL)
    return observations
}
