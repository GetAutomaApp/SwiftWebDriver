// ChromeDriverStartTests.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

@testable import SwiftWebDriver
import Testing

@Suite("Chrome Driver Start Tests", .serialized)
class ChromeDriverStartTests: ChromeDriverTest {
    @Test("Start & Stop")
    func startAndStop() async throws {
        let status = try await driver.status()
        #expect(status.value.message != "")
        let sessionId = try await driver.start()
        #expect(sessionId != "")
    }
}
