import SetVision
import Testing

struct DetectCardsTests {
    @Test func findRectangles() async throws {
        let imageURL = try #require(fixtureURL("set-cards-1.jpeg"))
        let rectangles = try await detectRectangles(in: imageURL)
        #expect(rectangles.count == 9)
    }

}
