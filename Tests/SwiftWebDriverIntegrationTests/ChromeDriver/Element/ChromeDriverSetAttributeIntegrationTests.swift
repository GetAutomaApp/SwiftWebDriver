// ChromeDriverSetAttributeIntegrationTests.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

@testable import SwiftWebDriver
import Testing

@Suite("Chrome Driver Set Attribute", .serialized)
internal class ChromeDriverSetAttributeIntegrationTests: ChromeDriverTest {
    @Test("Set Attribute")
    public func setAttribute() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let element = try await driver.findElement(.css(.id("attribute")))
        let newIdentifier = "newidentifier"
        try await driver.setAttribute(element: element, attributeName: "id", newValue: newIdentifier)

        let elementId = try await element.attribute(name: "id")
        #expect(elementId == newIdentifier)
    }

    deinit {
        // Add deinit logic here
    }
}
