// DriverNavigationIntegrationTests.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

@testable import SwiftWebDriver
import Testing

internal class DriverNavigationIntegrationTestBase<Configuration: DriverTestConfiguration>:
    DriverIntegrationTest<Configuration>
{
    internal func runGetNavigationTitleTest() async throws {
        page = "awaitTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let title = try await driver.navigationTitle()

        #expect(title.value != nil)
        #expect(title.value == "expect title")
    }

    internal func runWaitUntilElementsTest() async throws {
        page = "awaitTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        try await driver
            .findElement(.css(.id("startButton")))
            .click()

        let retries = 5
        let sleepDuration = 1

        let result = try await driver.waitUntil(
            .css(.id("asyncAddElement")),
            retryCount: retries,
            durationSeconds: sleepDuration
        )

        #expect(result)
    }
}

@Suite("Chrome Driver Navigation Tests", .serialized)
internal final class ChromeDriverNavigationIntegrationTests:
    DriverNavigationIntegrationTestBase<ChromeTestConfiguration>
{
    @Test("Get Navigation Title")
    internal func getNavigationTitle() async throws {
        try await runGetNavigationTitleTest()
    }

    @Test("Wait Until Element Exists")
    internal func waitUntilElements() async throws {
        try await runWaitUntilElementsTest()
    }
}

@Suite("Firefox Driver Navigation Tests", .serialized)
internal final class FirefoxDriverNavigationIntegrationTests:
    DriverNavigationIntegrationTestBase<FirefoxTestConfiguration>
{
    @Test("Get Navigation Title")
    internal func getNavigationTitle() async throws {
        try await runGetNavigationTitleTest()
    }

    @Test("Wait Until Element Exists")
    internal func waitUntilElements() async throws {
        try await runWaitUntilElementsTest()
    }
}
