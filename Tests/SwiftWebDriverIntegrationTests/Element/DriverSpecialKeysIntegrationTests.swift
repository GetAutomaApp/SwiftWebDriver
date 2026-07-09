// DriverSpecialKeysIntegrationTests.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

@testable import SwiftWebDriver
import Testing

internal class DriverSpecialKeysIntegrationTestBase<Configuration: DriverTestConfiguration>:
    DriverIntegrationTest<Configuration>
{
    func runTabCycleInputElementFocusTest() async throws {
        page = "testSpecialKeys.html"

        try await driver.navigateTo(url: testPageURL)

        let inputElement = try await driver.findElement(.css(.id("input1")))
        try await inputElement.send(value: .TAB)

        try await Task.sleep(for: .seconds(1))

        let activeElement = try await driver.getActiveElement()
        let activeElementId = try await activeElement.attribute(name: "id")

        #expect(activeElementId == "input2")
    }
}

@Suite("Chrome Driver Special Keys", .serialized)
internal final class ChromeDriverSpecialKeysIntegrationTests:
    DriverSpecialKeysIntegrationTestBase<ChromeTestConfiguration>
{
    @Test("Tab Should Cycle Input Elements Focus")
    func tabCycleInputElementFocus() async throws {
        try await runTabCycleInputElementFocusTest()
    }
}

@Suite("Firefox Driver Special Keys", .serialized)
internal final class FirefoxDriverSpecialKeysIntegrationTests:
    DriverSpecialKeysIntegrationTestBase<FirefoxTestConfiguration>
{
    @Test("Tab Should Cycle Input Elements Focus")
    func tabCycleInputElementFocus() async throws {
        try await runTabCycleInputElementFocusTest()
    }
}
