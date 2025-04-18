// ChromeDriverNavigationIntegrationTests.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

@testable import SwiftWebDriver
import Testing

@Suite("Chrome Driver Navigation Tests", .serialized)
internal class ChromeDriverNavigationIntegrationTests: ChromeDriverTest {
    @Test("Get Navigation Title")
    public func getNavigationTitle() async throws {
        page = "awaitTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let title = try await driver.navigationTitle()
        #expect(title.value != nil)
        #expect(title.value == "expect title")
    }

    @Test("Wait Until Element Exists")
    public func waitUntilElements() async throws {
        page = "awaitTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        try await driver
            .findElement(.css(.id("startButton")))
            .click()

        let retries = 5, sleepDuration = 1
        let result = try await driver
            .waitUntil(.css(.id("asyncAddElement")), retryCount: retries, durationSeconds: sleepDuration)

        #expect(result)
    }

    deinit {
        // Add deinit logic here
    }
}
