// DriverStartTests.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

@testable import SwiftWebDriver
import Testing

internal enum DriverStart {}

internal class DriverStartTest<Configuration: DriverTestConfiguration>:
    DriverIntegrationTest<Configuration>
{
    internal func runStartAndStopTest() async throws {
        let status = try await driver.status()
        #expect(status.value.message != "")

        let sessionId = try await driver.start()
        #expect(sessionId != "")
    }

    deinit {}
}

@Suite("Chrome Driver Start Tests", .serialized)
internal final class ChromeDriverStartTests:
    DriverStartTest<ChromeTestConfiguration>
{
    @Test("Start & Stop")
    internal func startAndStop() async throws {
        try await runStartAndStopTest()
    }

    deinit {}
}

@Suite("Firefox Driver Start Tests", .serialized)
internal final class FirefoxDriverStartTests:
    DriverStartTest<FirefoxTestConfiguration>
{
    @Test("Start & Stop")
    internal func startAndStop() async throws {
        try await runStartAndStopTest()
    }

    deinit {}
}
