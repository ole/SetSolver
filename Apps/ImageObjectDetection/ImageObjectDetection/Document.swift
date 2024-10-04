import SwiftUI
import UniformTypeIdentifiers

struct ImageDocument: FileDocument {
    static let readableContentTypes: [UTType] = [.image]
    static let writableContentTypes: [UTType] = []

    init(configuration: ReadConfiguration) throws {
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        fatalError("not implemented")
    }
}
