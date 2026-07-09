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
    static let suiteName = "Chrome"

    static let seleniumURL = URL(string: "http://selenium_chrome:4444")!

    nonisolated(unsafe) static let browserObject = ChromeOptions(args: [
        ChromeArgs(.disableDevShmUsage),
        ChromeArgs(.noSandbox)
    ])

    typealias ConcreteDriver = ChromeDriver
}

internal enum FirefoxTestConfiguration: DriverTestConfiguration {
    static let suiteName = "Firefox"

    static let seleniumURL = URL(string: "http://selenium_firefox:4444")!

    nonisolated(unsafe) static let browserObject = FirefoxOptions(
        args: [
            FirefoxArgs(FirefoxArgs.Argument.headless)
        ],
        log: FirefoxLog(level: .info)
    )

    typealias ConcreteDriver = FirefoxDriver
}

internal class DriverIntegrationTest<Configuration: DriverTestConfiguration> {
    public let baseUrl = "http://httpd"

    public var testPageURL: URL {
        URL(string: "\(baseUrl)/\(page)")!
    }

    public var page = "index.html"

    public var driver: WebDriver<Configuration.ConcreteDriver>

    public required init() async throws {
        driver = WebDriver(
            driver: Configuration.ConcreteDriver(
                driverURL: Configuration.seleniumURL,
                browserObject: Configuration.browserObject
            )
        )

        try await driver.start()
    }
}

// internal class ChromeDriverTest: ChromeDriverIntegrationTestsBase {
//     public let baseUrl: String = "http://httpd"
//     public var testPageURL: URL {
//         // swiftlint:disable:next force_unwrapping
//         .init(string: "\(baseUrl)/\(page)")!
//     }
//
//     public var page: String = "index.html"
//     public var driver: WebDriver<ChromeDriver>
//
//     public init() async throws {
//         // swiftlint:disable:next force_unwrapping
//         let driverURL = URL(string: "http://selenium_chrome:4444")!
//         let chromeOptions = ChromeOptions(args: [
//             ChromeArgs(.disableDevShmUsage),
//             Args(.noSandbox),
//         ])
//
//         // Initialize the WebDriver on the main actor
//         driver = WebDriver(
//             driver: ChromeDriver(
//                 driverURL: driverURL,
//                 browserObject: chromeOptions
//             )
//         )
//
//         try await driver.start()
//     }
//
//     deinit {
//         // Add deinit here
//     }
// }
