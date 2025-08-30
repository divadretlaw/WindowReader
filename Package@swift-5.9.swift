// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WindowReader",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "WindowReader",
            targets: ["WindowReader"]
        )
    ],
    targets: [
        .target(name: "WindowReader")
    ]
)
