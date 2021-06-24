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
    ],
    targets: [
        .target(
            name: "LicenseParser",
            dependencies: []
        ),
    ]
)
