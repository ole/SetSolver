// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "SetSolver",
    platforms: [.macOS(.v15), .iOS(.v18), .macCatalyst(.v18), .tvOS(.v18), .watchOS(.v11), .visionOS(.v2)],
    products: [
        .library(name: "SetUI", targets: ["SetUI"]),
        .library(name: "SetVision", targets: ["SetVision"]),
        .library(name: "SetSolver", targets: ["SetSolver"]),
        .executable(name: "DetectRectangles", targets: ["DetectRectanglesCLI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
    ],
    targets: [
        // Provides SwiftUI views for rendering cards for the card game
        // [Set](https://en.wikipedia.org/wiki/Set_%28card_game%29).
        .target(
            name: "SetUI",
            dependencies: ["SetSolver"],
            exclude: ["README.md"],
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny"),
                .enableExperimentalFeature("InternalImportsByDefault"),
            ]
        ),
        // Computer vision for the card game
        // [Set](https://en.wikipedia.org/wiki/Set_%28card_game%29).
        .target(
            name: "SetVision",
            dependencies: ["SetSolver"],
            exclude: ["README.md"],
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny"),
                .enableExperimentalFeature("InternalImportsByDefault"),
            ]
        ),
        .testTarget(
            name: "SetVisionTests",
            dependencies: ["SetVision"],
            resources: [
                .copy("Fixtures"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny"),
                .enableExperimentalFeature("InternalImportsByDefault"),
            ]
        ),
        // Extract detected rectangles from image files
        .executableTarget(
            name: "DetectRectanglesCLI",
            dependencies: [
                "SetVision",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny"),
                .enableExperimentalFeature("InternalImportsByDefault"),
            ]
        ),
        // Provides types for modeling the card game
        // [Set](https://en.wikipedia.org/wiki/Set_%28card_game%29),
        // and a solver for the game.
        .target(
            name: "SetSolver",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
            ],
            exclude: ["README.md"],
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny"),
                .enableExperimentalFeature("InternalImportsByDefault"),
            ]
        ),
        .testTarget(
            name: "SetSolverTests",
            dependencies: ["SetSolver"],
            swiftSettings: [
                .enableUpcomingFeature("ExistentialAny"),
                .enableExperimentalFeature("InternalImportsByDefault"),
            ]
        ),
    ]
)
