import SwiftUI

@main
struct ImageObjectDetectionApp: App {
    var body: some Scene {
        DocumentGroup(viewing: ImageDocument.self) { config in
            DocumentView(imageURL: config.fileURL!)
        }
    }
}
