// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-comparison",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(name: "Comparison", targets: ["Comparison"]),

        .library(name: "Comparison Foundation Integration", targets: ["Comparison Foundation Integration"]),
        .library(name: "Comparison Test Support", targets: ["Comparison Test Support"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-equation.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-property.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Comparison",
            dependencies: [
                .product(name: "Equation", package: "swift-equation"),
                .product(name: "Property", package: "swift-property"),
            ],
            path: "Sources/Comparison"
        ),
        
        .target(
            name: "Comparison Foundation Integration",
            dependencies: [
                .target(name: "Comparison"),
            ],
            path: "Sources/Comparison Foundation Integration"
        ),
        .target(
            name: "Comparison Test Support",
            dependencies: [
                .target(name: "Comparison"),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Comparison Tests",
            dependencies: [
                .target(name: "Comparison"),
                .target(name: "Comparison Test Support"),
                .target(name: "Comparison Foundation Integration"),
            ],
            path: "Tests/Comparison Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets {
    target.swiftSettings = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]
}
