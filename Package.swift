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
            name: "Comparison Primitive",
            targets: ["Comparison Primitive"]
        ),

        .library(
            name: "Comparison Protocol",
            targets: ["Comparison Protocol"]
        ),
        .library(
            name: "Comparison Tagged",
            targets: ["Comparison Tagged"]
        ),
        .library(
            name: "Comparison Property",
            targets: ["Comparison Property"]
        ),

        .library(
            name: "Comparison Standard Library Integration",
            targets: ["Comparison Standard Library Integration"]
        ),

        .library(
            name: "Comparison",
            targets: ["Comparison"]
        ),

        .library(
            name: "Comparison Test Support",
            targets: ["Comparison Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-equation.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-property.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-tagged.git",
            branch: "main"
        ),
    ],
    targets: [

        .target(
            name: "Comparison Primitive",
            dependencies: []
        ),

        .target(
            name: "Comparison Protocol",
            dependencies: [
                "Comparison Primitive",
                .product(name: "Equation", package: "swift-equation"),
            ]
        ),
        .target(
            name: "Comparison Tagged",
            dependencies: [
                "Comparison Protocol",
                .product(name: "Tagged", package: "swift-tagged"),
            ]
        ),
        .target(
            name: "Comparison Property",
            dependencies: [
                "Comparison Protocol",
                .product(name: "Property", package: "swift-property"),
            ]
        ),

        .target(
            name: "Comparison Standard Library Integration",
            dependencies: [
                "Comparison Protocol",
                "Comparison Property",
            ]
        ),

        .target(
            name: "Comparison",
            dependencies: [
                "Comparison Primitive",
                "Comparison Protocol",
                "Comparison Tagged",
                "Comparison Property",
                "Comparison Standard Library Integration",
                .product(name: "Equation", package: "swift-equation"),
            ]
        ),

        .target(
            name: "Comparison Test Support",
            dependencies: [
                "Comparison",
                .product(
                    name: "Tagged Test Support",
                    package: "swift-tagged"
                ),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Comparison Tests",
            dependencies: [
                "Comparison",
                "Comparison Test Support",
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
