// FirefoxDriverIntegrationTestsBase.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Foundation
@testable import SwiftWebDriver

internal protocol FirefoxDriverIntegrationTestsBase {
    var driver: WebDriver<FirefoxDriver> { get set }
    var testPageURL: URL { get }
    var baseUrl: String { get }
    var page: String { get set }
}

internal class FirefoxDriverTest: FirefoxDriverIntegrationTestsBase {
    public let baseUrl: String = "http://localhost"
    public var testPageURL: URL {
        // swiftlint:disable:next force_unwrapping
        .init(string: "\(baseUrl)/\(page)")!
    }

    public var page: String = "index.html"
    public var driver: WebDriver<FirefoxDriver>

    public init() async throws {
        // swiftlint:disable:next force_unwrapping
        let driverURL = URL(string: "http://selenium_firefox:4444")!

        let firefoxOptions = FirefoxOptions(
            args: [FirefoxArgs(.headless as FirefoxArgs.Argument)],
        )

        // Initialize the WebDriver on the main actor
        driver = WebDriver(
            driver: FirefoxDriver(
                driverURL: driverURL,
                browserObject: firefoxOptions
            )
        )

        try await driver.start()
    }

    deinit {
        // Add deinit here
    }
}
