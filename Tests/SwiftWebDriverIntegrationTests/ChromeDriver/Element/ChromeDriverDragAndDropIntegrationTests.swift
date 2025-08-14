// ChromeDriverDragAndDropIntegrationTests.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

@testable import SwiftWebDriver
import Testing

@Suite("Chrome Driver Drag and Drop Integration Tests", .serialized)
internal class ChromeDriverDragAndDropIntegrationTests: ChromeDriverTest {
    /// Drag and drop draggable element to another element, testing the `dragAndDrop` method.
    /// This test tests the JavaScript script executed in the DOM to drag the draggable element to the other element.
    @Test("Drag Element To Another (JavaScript)")
    public func dragAndDropDraggableElementToAnother() async throws {
        page = "dragTarget.html"
        try await dragAndDrop()
    }

    @Test("Drag Element To Another (WebDriver Actions API)")
    public func dragAndDropElementToAnother() async throws {
        page = "dragBox.html"
        try await dragAndDrop()
    }

    private func dragAndDrop() async throws {
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let sourceElement = try await driver.findElement(.css(.id("source")))
        let targetElement = try await driver.findElement(.css(.id("target")))

        try await driver.dragAndDrop(from: sourceElement, to: targetElement)

        let targetElementText = try await driver.getProperty(element: targetElement, propertyName: "innerText").value?
            .stringValue

        #expect(targetElementText == "DROPPED!")
    }

    deinit {}
}
