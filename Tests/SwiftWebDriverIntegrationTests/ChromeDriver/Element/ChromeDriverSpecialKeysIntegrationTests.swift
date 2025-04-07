// ChromeDriverSpecialKeysIntegrationTests.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

@testable import SwiftWebDriver
import Testing

@Suite("Chrome Driver Special Keys", .serialized)
internal class ChromeDriverSpecialKeysIntegrationTests: ChromeDriverTest {
    @Test("Tab Should Cycle Input Elements Focus")
    public func tabCycleInputElementFocus() async throws {
        page = "testSpecialKeys.html"

        try await driver.navigateTo(url: testPageURL)
        let inputElement = try await driver.findElement(.css(.id("input1")))
        try await inputElement.send(value: .TAB)
        try await Task.sleep(for: .seconds(1))
        let activeElement = try await driver.getActiveElement()
        #expect(try await activeElement.attribute(name: "id") == "input2")
    }

    deinit {
        // Add deinit logic here
    }
}
