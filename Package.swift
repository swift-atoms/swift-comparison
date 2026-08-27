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
        .library(
            name: "Comparison",
            targets: ["Comparison"]
        ),
        .library(
            name: "Comparison Standard Library Integration",
            targets: ["Comparison Standard Library Integration"]
        ),
        .library(
            name: "Comparison Apple Foundation Integration",
            targets: ["Comparison Apple Foundation Integration"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Comparison",
            dependencies: []
        ),
        .target(
            name: "Comparison Standard Library Integration",
            dependencies: ["Comparison"]
        ),
        .target(
            name: "Comparison Apple Foundation Integration",
            dependencies: [
                "Comparison",
                "Comparison Standard Library Integration",
            ]
        ),
        .testTarget(
            name: "Comparison Tests",
            dependencies: [
                "Comparison",
                "Comparison Standard Library Integration",
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
