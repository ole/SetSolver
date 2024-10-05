import SetVision
import Testing

struct DetectCardsTests {
    @Test(arguments: [
        (filename: "set-cards-1.jpeg", expect: 9),
        (filename: "set-cards-2.jpeg", expect: 9),
        (filename: "set-cards-3.jpeg", expect: 9),
        (filename: "set-cards-4.jpeg", expect: 9),
        (filename: "set-cards-5.jpeg", expect: 9),
        (filename: "set-cards-6.jpeg", expect: 9),
        (filename: "set-cards-7.jpeg", expect: 9),
        (filename: "set-cards-8.jpeg", expect: 9),
        (filename: "set-cards-9.jpeg", expect: 9),
    ])
    func findRectangles(imageFilename: String, expectedRectCount: Int) async throws {
        let imageURL = try #require(fixtureURL(imageFilename))
        let rectangles = try await detectRectangles(
            in: imageURL,
            minimumSize: 0.1,
            minimumConfidence: 0.9
        )
        #expect(rectangles.count == expectedRectCount, "\(imageFilename)")
    }
}
