// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "swift-webdriver",
    platforms: [
            .macOS(.v10_15),
            .iOS(.v13),
            .tvOS(.v13),
            .watchOS(.v6)
    ],
    products: [
        .library(
            name: "SwiftWebDriver",
            targets: ["SwiftWebDriver"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.10.0"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.40.0"),
        .package(url: "https://github.com/GetAutomaApp/swift-any-codable.git", branch: "main")
    ],
    targets: [
        .target(
            name: "SwiftWebDriver",
            dependencies: [
                .product(name: "AsyncHTTPClient", package: "async-http-client"),
                .product(name: "NIOFoundationCompat", package: "swift-nio"),
                .product(name: "AnyCodable", package: "swift-any-codable")
            ]),
        .testTarget(
            name: "SwiftWebDriverTests",
            dependencies: ["SwiftWebDriver"]),
        .testTarget(
            name: "SwiftWebDriverIntegratedTests",
            dependencies: ["SwiftWebDriver"])
    ]
)
