// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LicenseParser",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "LicenseParser",
            targets: ["LicenseParser"]
        ),
    ],
    dependencies: [
        .package(name: "Quick", url: "https://github.com/Quick/Quick", from: "3.1.2"),
        .package(name: "Nimble", url: "https://github.com/Quick/nimble", from: "9.0.0"),
    ],
    targets: [
        .target(
            name: "LicenseParser",
            dependencies: []
        ),
        .testTarget(
            name: "LicenseParserTests",
            dependencies: ["LicenseParser", "Quick", "Nimble"]
        ),
    ]
)
