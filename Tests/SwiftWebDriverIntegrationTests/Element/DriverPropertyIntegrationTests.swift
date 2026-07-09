// DriverPropertyIntegrationTests.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

@testable import SwiftWebDriver
import Testing

internal class DriverPropertyIntegrationTest<Configuration: DriverTestConfiguration>:
    DriverIntegrationTest<Configuration>
{
    /// Test `getProperty()` method, a method to get a specific property value from an element.
    internal func runGetPropertyTest() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let updatedElementValue = "NewElementValue"

        try await driver.execute("""
            let element = document.getElementById('attribute')
            element.value = '\(updatedElementValue)'
        """)

        let element = try await driver.findElement(.css(.id("attribute")))

        guard
            let elementValue = try await driver
            .getProperty(element: element, propertyName: "value")
            .value?
            .stringValue
        else {
            #expect(Bool(false), "Could not convert element value to string value")
            return
        }

        #expect(elementValue == updatedElementValue)
    }

    /// Test `setProperty()` method, a method to set a specific property value from an element.
    internal func runSetPropertyTest() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let element = try await driver.findElement(.css(.id("setproperty")))
        let newPropertyValue = "element new inner text"

        try await driver.setProperty(
            element: element,
            propertyName: "innerText",
            newValue: newPropertyValue
        )

        guard
            let elementInnerTextValue = try await driver
            .getProperty(element: element, propertyName: "innerText")
            .value?
            .stringValue
        else {
            #expect(Bool(false), "Could not convert element innerText value to string value")
            return
        }

        #expect(newPropertyValue == elementInnerTextValue)
    }
}

@Suite("Chrome Driver Property Integration Tests", .serialized)
internal final class ChromeDriverPropertyIntegrationTests:
    DriverPropertyIntegrationTest<ChromeTestConfiguration>
{
    @Test("Get Property")
    internal func getProperty() async throws {
        try await runGetPropertyTest()
    }

    @Test("Set Property")
    internal func setProperty() async throws {
        try await runSetPropertyTest()
    }
}

@Suite("Firefox Driver Property Integration Tests", .serialized)
internal final class FirefoxDriverPropertyIntegrationTests:
    DriverPropertyIntegrationTest<FirefoxTestConfiguration>
{
    @Test("Get Property")
    internal func getProperty() async throws {
        try await runGetPropertyTest()
    }

    @Test("Set Property")
    internal func setProperty() async throws {
        try await runSetPropertyTest()
    }
}
