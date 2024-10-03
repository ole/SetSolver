import Foundation

func fixtureURL(_ filename: String) -> URL? {
    Bundle.module.url(forResource: filename, withExtension: nil, subdirectory: "Fixtures")
}
