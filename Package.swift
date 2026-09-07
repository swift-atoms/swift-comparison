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
        .library(name: "Comparison Protocol", targets: ["Comparison Protocol"]),
        .library(name: "Comparison Property", targets: ["Comparison Property"]),
        .library(
            name: "Comparison Standard Library Integration",
            targets: ["Comparison Standard Library Integration"]
        ),
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

        .target(name: "Comparison", dependencies: []),

        .target(
            name: "Comparison Protocol",
            dependencies: [
                .target(name: "Comparison"),
                .product(name: "Equation Protocol", package: "swift-equation"),
            ]
        ),
        .target(
            name: "Comparison Property",
            dependencies: [
                .target(name: "Comparison Protocol"),
                .product(name: "Property", package: "swift-property"),
            ]
        ),

        .target(
            name: "Comparison Standard Library Integration",
            dependencies: [
                .target(name: "Comparison Protocol"),
                .target(name: "Comparison Property"),
            ]
        ),
        .testTarget(
            name: "Comparison Tests",
            dependencies: [
                .target(name: "Comparison"),
            ]
        ),
        .testTarget(
            name: "Comparison Protocol Tests",
            dependencies: [
                .target(name: "Comparison Protocol"),
            ]
        ),
        .testTarget(
            name: "Comparison Property Tests",
            dependencies: [
                .target(name: "Comparison Property"),
            ]
        ),
        .testTarget(
            name: "Comparison Standard Library Integration Tests",
            dependencies: [
                .target(name: "Comparison Standard Library Integration"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
