// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BlackMagic",
    platforms: [
        .macOS(SupportedPlatform.MacOSVersion.v10_14)
    ],
    products: [
        .library(
            name: "BlackMagic",
            targets: ["BlackMagic"]),
    ],
    targets: [
        .target(
            name: "BlackMagic",
            dependencies: []),
        .testTarget(
            name: "BlackMagicTests",
            dependencies: ["BlackMagic"]),
    ]
)
