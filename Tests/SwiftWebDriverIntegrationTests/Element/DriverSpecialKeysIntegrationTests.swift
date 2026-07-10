// DriverSpecialKeysIntegrationTests.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

@testable import SwiftWebDriver
import Testing

internal enum DriverSpecialKeysIntegration {}

internal class DriverSpecialKeysIntegrationTest<Configuration: DriverTestConfiguration>:
    DriverIntegrationTest<Configuration>
{
    internal func runTabCycleInputElementFocusTest() async throws {
        page = "testSpecialKeys.html"

        try await driver.navigateTo(url: testPageURL)

        let inputElement = try await driver.findElement(.css(.id("input1")))
        try await inputElement.send(value: .TAB)

        try await Task.sleep(for: .seconds(1))

        let activeElement = try await driver.getActiveElement()
        let activeElementId = try await activeElement.attribute(name: "id")

        #expect(activeElementId == "input2")
    }

    deinit {}
}

@Suite("Chrome Driver Special Keys", .serialized)
internal final class ChromeDriverSpecialKeysIntegrationTests:
    DriverSpecialKeysIntegrationTest<ChromeTestConfiguration>
{
    @Test("Tab Should Cycle Input Elements Focus")
    internal func tabCycleInputElementFocus() async throws {
        try await runTabCycleInputElementFocusTest()
    }

    deinit {}
}

@Suite("Firefox Driver Special Keys", .serialized)
internal final class FirefoxDriverSpecialKeysIntegrationTests:
    DriverSpecialKeysIntegrationTest<FirefoxTestConfiguration>
{
    @Test("Tab Should Cycle Input Elements Focus")
    internal func tabCycleInputElementFocus() async throws {
        try await runTabCycleInputElementFocusTest()
    }

    deinit {}
}
