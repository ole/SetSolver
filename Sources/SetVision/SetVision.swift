import Vision

public func detectRectangles(in imageURL: URL) async throws -> [RectangleObservation] {
    var request = DetectRectanglesRequest(.revision1)
    request.maximumObservations = 81 // a full Set deck has 81 cards
    let observations = try await request.perform(on: imageURL)
    return observations
}
