// DriverStartTests.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

@testable import SwiftWebDriver
import Testing

internal class DriverStartTestBase<Configuration: DriverTestConfiguration>:
    DriverIntegrationTest<Configuration>
{
    internal func runStartAndStopTest() async throws {
        let status = try await driver.status()
        #expect(status.value.message != "")

        let sessionId = try await driver.start()
        #expect(sessionId != "")
    }
}

@Suite("Chrome Driver Start Tests", .serialized)
internal final class ChromeDriverStartTests:
    DriverStartTestBase<ChromeTestConfiguration>
{
    @Test("Start & Stop")
    internal func startAndStop() async throws {
        try await runStartAndStopTest()
    }
}

@Suite("Firefox Driver Start Tests", .serialized)
internal final class FirefoxDriverStartTests:
    DriverStartTestBase<FirefoxTestConfiguration>
{
    @Test("Start & Stop")
    internal func startAndStop() async throws {
        try await runStartAndStopTest()
    }
}
