// ChromeDriverIntegrationTestsBase.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

import Foundation
@testable import SwiftWebDriver

internal protocol ChromeDriverIntegrationTestsBase {
    var driver: WebDriver<ChromeDriver> { get set }
    var testPageURL: URL { get }
    var baseUrl: String { get }
    var page: String { get set }
}

internal class ChromeDriverTest: ChromeDriverIntegrationTestsBase {
    public let baseUrl: String = "http://localhost"
    public var testPageURL: URL {
        // swiftlint:disable:next force_unwrapping
        .init(string: "\(baseUrl)/\(page)")!
    }

    public var page: String = "index.html"
    public var driver: WebDriver<ChromeDriver>

    public init() async throws {
        // swiftlint:disable:next force_unwrapping
        let driverURL = URL(string: "http://localhost:4444")!
        let chromeOptions = ChromeOptions(args: [
            Args(.disableDevShmUsage),
            Args(.noSandbox),
        ])

        // Initialize the WebDriver on the main actor
        driver = WebDriver(
            driver: ChromeDriver(
                driverURL: driverURL,
                browserObject: chromeOptions
            )
        )

        try await driver.start()
    }

    deinit {
        // Add deinit here
    }
}
