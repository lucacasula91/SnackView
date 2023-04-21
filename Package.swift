// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SnackView",
    platforms: [
        .iOS(.v13),
        ],
    products: [
        .library(
            name: "SnackView",
            targets: ["SnackView"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "10.0.0")),
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "5.0.0"))

    ],
    targets: [
        .target(
            name: "SnackView",
            dependencies: []),
        .testTarget(
            name: "SnackViewTests",
            dependencies: ["SnackView", "Quick", "Nimble"]),
    ]
)
