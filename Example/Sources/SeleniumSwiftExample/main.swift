// Main.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import SwiftWebDriver

internal enum Main {
    /// Executable main procedure for this example package
    public static func main() async throws {
        let chromeOption = ChromeOptions(
            args: [
                Args(.headless),
            ]
        )

        let chromeDriver = try ChromeDriver(
            driverURLString: "http://localhost:4444",
            browserObject: chromeOption
        )

        let driver = WebDriver(
            driver: chromeDriver
        )

        do {
            let status = try await driver.status()
            print(status)
            let sessionId = try await driver.start()
            print(sessionId)
            try await driver.stop()
        } catch {
            print(error)
        }
    }
}

try await Main.main()
