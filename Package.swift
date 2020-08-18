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
            .revision("fedc632a349ae01284354903f99dfb0969c3fde6")
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
