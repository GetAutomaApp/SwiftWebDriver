// DriverSetAttributeIntegrationTests.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

@testable import SwiftWebDriver
import Testing

internal class DriverSetAttributeIntegrationTestBase<Configuration: DriverTestConfiguration>:
    DriverIntegrationTest<Configuration>
{
    internal func runSetAttributeTest() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let element = try await driver.findElement(.css(.id("attribute")))
        let newIdentifier = "newidentifier"

        try await driver.setAttribute(
            element: element,
            attributeName: "id",
            newValue: newIdentifier
        )

        let elementId = try await element.attribute(name: "id")

        #expect(elementId == newIdentifier)
    }
}

@Suite("Chrome Driver Set Attribute", .serialized)
internal final class ChromeDriverSetAttributeIntegrationTests:
    DriverSetAttributeIntegrationTestBase<ChromeTestConfiguration>
{
    @Test("Set Attribute")
    internal func setAttribute() async throws {
        try await runSetAttributeTest()
    }
}

@Suite("Firefox Driver Set Attribute", .serialized)
internal final class FirefoxDriverSetAttributeIntegrationTests:
    DriverSetAttributeIntegrationTestBase<FirefoxTestConfiguration>
{
    @Test("Set Attribute")
    internal func setAttribute() async throws {
        try await runSetAttributeTest()
    }
}
