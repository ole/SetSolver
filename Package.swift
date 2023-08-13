// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SetSolver",
    platforms: [.macOS(.v13), .iOS(.v16)],
    products: [
        .library(name: "SetUI", targets: ["SetUI"]),
        .library(name: "SetSolver", targets: ["SetSolver"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "SetUI",
            dependencies: ["SetSolver"]
        ),
        .target(
            name: "SetSolver",
            dependencies: [
                .product(name: "Algorithms", package: "swift-algorithms"),
            ]
        ),
        .testTarget(
            name: "SetSolverTests",
            dependencies: ["SetSolver"]
        ),
    ]
)
