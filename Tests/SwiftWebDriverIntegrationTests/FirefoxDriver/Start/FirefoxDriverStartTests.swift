// FirefoxDriverStartTests.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

@testable import SwiftWebDriver
import Testing

@Suite("Firefox Driver Start Tests", .serialized)
internal class FirefoxDriverStartTests: FirefoxDriverTest {
    @Test("Start & Stop")
    public func startAndStop() async throws {
        let status = try await driver.status()
        #expect(status.value.message != "")
        let sessionId = try await driver.start()
        #expect(sessionId != "")
    }

    deinit {
        // Add deinit logic here
    }
}
