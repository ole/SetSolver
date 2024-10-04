import Vision

/// - Parameter minimumSize: The minimum size of the rectangle to be detected,
///   as a proportion of the smallest dimension of the image.
/// - Parameter minimumConfidence: The minimum acceptable confidence level for
///   detected rectangles. Ranges from 0.0 to 1.0, inclusive, where 0.0
///   represents no confidence, and 1.0 represents full confidence.
public func detectRectangles(
    in imageURL: URL,
    minimumSize: Float,
    minimumConfidence: Float
) async throws -> [RectangleObservation] {
    var request = DetectRectanglesRequest(.revision1)
    // A full Set deck has 81 cards
    request.maximumObservations = 81
    request.minimumSize = minimumSize
    request.minimumConfidence = minimumConfidence
    let observations = try await request.perform(on: imageURL)
    return observations
}
