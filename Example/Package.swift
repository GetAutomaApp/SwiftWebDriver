// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SeleniumSwiftExample",
    platforms: [
        .macOS(.v12),
    ],
    dependencies: [
        .package(name: "SwiftWebDriver", path: "../")
    ],
    targets: [
        .executableTarget(
            name: "SeleniumSwiftExample",
            dependencies: [
                .product(name: "SwiftWebDriver", package: "SwiftWebDriver")
            ]),
        .testTarget(
            name: "SeleniumSwiftExampleTests",
            dependencies: ["SeleniumSwiftExample"]),
    ]
)
