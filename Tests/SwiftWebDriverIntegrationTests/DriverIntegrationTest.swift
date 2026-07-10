// DriverIntegrationTest.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Foundation
@testable import SwiftWebDriver

internal protocol DriverTestConfiguration {
    associatedtype ConcreteDriver: Driver

    static var suiteName: String { get }
    static var seleniumURL: URL { get }
    static var browserObject: ConcreteDriver.BrowserOption { get }
}

internal enum ChromeTestConfiguration: DriverTestConfiguration {
    internal static let suiteName = "Chrome"

    internal static let seleniumURL = URL(string: "http://selenium_chrome:4444")!

    nonisolated(unsafe) internal static let browserObject = ChromeOptions(args: [
        ChromeArgs(.disableDevShmUsage),
        ChromeArgs(.noSandbox)
    ])

    internal typealias ConcreteDriver = ChromeDriver
}

internal enum FirefoxTestConfiguration: DriverTestConfiguration {
    internal static let suiteName = "Firefox"

    internal static let seleniumURL = URL(string: "http://selenium_firefox:4444")!

    nonisolated(unsafe) internal static let browserObject = FirefoxOptions(
        args: [
            FirefoxArgs(FirefoxArgs.Argument.headless)
        ],
        log: FirefoxLog(level: .info)
    )

    internal typealias ConcreteDriver = FirefoxDriver
}

internal class DriverIntegrationTest<Configuration: DriverTestConfiguration> {
    internal let baseUrl = "http://httpd"

    internal var testPageURL: URL {
        guard let url = URL(string: "\(baseUrl)/\(page)") else {
            fatalError("Invalid test page URL for page: \(page)")
        }
        return url
    }

    internal var page = "index.html"

    internal var driver: WebDriver<Configuration.ConcreteDriver>

    internal required init() async throws {
        driver = WebDriver(
            driver: Configuration.ConcreteDriver(
                driverURL: Configuration.seleniumURL,
                browserObject: Configuration.browserObject
            )
        )

        try await driver.start()
    }

    deinit {}
}
