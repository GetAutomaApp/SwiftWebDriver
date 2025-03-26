// ChromeDriverIntegrationTestsBase.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

import Foundation
@testable import SwiftWebDriver

protocol ChromeDriverIntegrationTests {
    var driver: WebDriver<ChromeDriver> { get set }
    var testPageURL: URL { get }
    var baseUrl: String { get }
    var page: String { get set }
}

class ChromeDriverTest: ChromeDriverIntegrationTests {
    let baseUrl: String = "http://localhost"
    var testPageURL: URL {
        .init(string: "\(baseUrl)/\(page)")!
    }

    var page: String = "index.html"
    var driver: WebDriver<ChromeDriver>

    init() async throws {
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
}
