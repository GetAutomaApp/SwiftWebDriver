// ChromeDriverDragAndDropIntegrationTests.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

@testable import SwiftWebDriver
import Testing

@Suite("Chrome Driver Drag and Drop Integration Tests", .serialized)
internal class ChromeDriverDragAndDropIntegrationTests: ChromeDriverTest {
    @Test("Drag Element To Another")
    func dragAndDropElementToAnother() async throws {
        page = "dragTarget.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let sourceElement = try await driver.findElement(.css(.id("source")))
        let targetElement = try await driver.findElement(.css(.id("target")))

        try await driver.dragAndDrop(from: sourceElement, to: targetElement)

        let targetElementText = try await driver.getProperty(element: targetElement, propertyName: "innerText").value?
            .stringValue

        #expect(targetElementText == "DROPPED!")
    }

    @Test("Set Property")
    func setProperty() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)
        let element = try await driver.findElement(.css(.id("setproperty")))
        let newPropertyValue = "element new inner text"

        try await driver.setProperty(element: element, propertyName: "innerText", newValue: newPropertyValue)
        guard
            let elementInnerTextValue = try await driver.getProperty(element: element, propertyName: "innerText").value?
            .stringValue
        else {
            #expect(Bool(false), "Could not convert element innerText value to string value")
            return
        }

        #expect(newPropertyValue == elementInnerTextValue)
    }

    deinit {}
}
