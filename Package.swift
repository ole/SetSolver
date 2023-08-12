// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SetSolver",
    products: [
        .library(
            name: "SetSolver",
            targets: ["SetSolver"]
        ),
    ],
    targets: [
        .target(
            name: "SetSolver"
        ),
        .testTarget(
            name: "SetSolverTests",
            dependencies: ["SetSolver"]
        ),
    ]
)
