// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-comparison-primitives",
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
            name: "Comparison Protocol Primitives",
            targets: ["Comparison Protocol Primitives"]
        ),
        .library(
            name: "Comparison Tagged Primitives",
            targets: ["Comparison Tagged Primitives"]
        ),
        .library(
            name: "Comparison Property Primitives",
            targets: ["Comparison Property Primitives"]
        ),

        .library(
            name: "Comparison Primitives Standard Library Integration",
            targets: ["Comparison Primitives Standard Library Integration"]
        ),

        .library(
            name: "Comparison Primitives",
            targets: ["Comparison Primitives"]
        ),

        .library(
            name: "Comparison Primitives Test Support",
            targets: ["Comparison Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-primitives/swift-equation-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-property-primitives.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-primitives/swift-tagged-primitives.git",
            branch: "main"
        ),
    ],
    targets: [

        .target(
            name: "Comparison Primitive",
            dependencies: []
        ),

        .target(
            name: "Comparison Protocol Primitives",
            dependencies: [
                "Comparison Primitive",
                .product(name: "Equation Primitives", package: "swift-equation-primitives"),
            ]
        ),
        .target(
            name: "Comparison Tagged Primitives",
            dependencies: [
                "Comparison Protocol Primitives",
                .product(name: "Tagged Primitives", package: "swift-tagged-primitives"),
            ]
        ),
        .target(
            name: "Comparison Property Primitives",
            dependencies: [
                "Comparison Protocol Primitives",
                .product(name: "Property Primitives", package: "swift-property-primitives"),
            ]
        ),

        .target(
            name: "Comparison Primitives Standard Library Integration",
            dependencies: [
                "Comparison Protocol Primitives",
                "Comparison Property Primitives",
            ]
        ),

        .target(
            name: "Comparison Primitives",
            dependencies: [
                "Comparison Primitive",
                "Comparison Protocol Primitives",
                "Comparison Tagged Primitives",
                "Comparison Property Primitives",
                "Comparison Primitives Standard Library Integration",
                .product(name: "Equation Primitives", package: "swift-equation-primitives"),
            ]
        ),

        .target(
            name: "Comparison Primitives Test Support",
            dependencies: [
                "Comparison Primitives",
                .product(
                    name: "Tagged Primitives Test Support",
                    package: "swift-tagged-primitives"
                ),
            ],
            path: "Tests/Support"
        ),
        .testTarget(
            name: "Comparison Primitives Tests",
            dependencies: [
                "Comparison Primitives",
                "Comparison Primitives Test Support",
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
