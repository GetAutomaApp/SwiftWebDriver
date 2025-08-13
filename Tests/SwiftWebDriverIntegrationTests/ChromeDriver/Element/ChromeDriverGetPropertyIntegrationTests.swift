// ChromeDriverGetPropertyIntegrationTests.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

@testable import SwiftWebDriver
import Testing

@Suite("Chrome Driver Get Property", .serialized)
internal class ChromeDriverGetPropertyIntegrationTests: ChromeDriverTest {
    @Test("Get Property")
    func getProperty() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)
        let updatedElementValue = "NewElementValue"
        try await driver.execute("""
            let element = document.getElementById('attribute')
            element.value = '\(updatedElementValue)'
        """)
        let element = try await driver.findElement(.css(.id("attribute")))
        guard
            let elementValue = try await driver.getProperty(element: element, property: "value").value?.stringValue
        else {
            #expect(Bool(false), "Could not convert element value to string value")
            return
        }

        #expect(elementValue == updatedElementValue)
    }

    deinit {}
}
