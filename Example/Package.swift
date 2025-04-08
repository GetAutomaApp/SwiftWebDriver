// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SeleniumSwiftExample",
    platforms: [
        .macOS(.v12),
    ],
    dependencies: [
        .package(url: "https://github.com/GetAutomaApp/SwiftWebDriver.git", from: "0.2.0"),
    ],
    targets: [
        .executableTarget(
            name: "SeleniumSwiftExample",
            dependencies: [
                .product(name: "SwiftWebDriver", package: "SwiftWebDriver"),
            ]
        ),
        .testTarget(
            name: "SeleniumSwiftExampleTests",
            dependencies: ["SeleniumSwiftExample"]
        ),
    ]
)
