// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Cardano",
    products: [
        .library(
            name: "Cardano",
            targets: ["Cardano"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(
            url: "https://github.com/hellc/CatalystNet.git",
            .revision("e4fc298e83b4dc6a28331343ea5d3e0b87f1466a")
        )
    ],
    targets: [
        .target(
            name: "Cardano",
            dependencies: ["CatalystNet"]),
        .testTarget(
            name: "CardanoTests",
            dependencies: ["Cardano"]),
    ]
)
