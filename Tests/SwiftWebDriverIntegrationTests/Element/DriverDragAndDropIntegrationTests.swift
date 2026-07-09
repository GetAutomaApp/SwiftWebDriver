// DriverDragAndDropIntegrationTests.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

@testable import SwiftWebDriver
import Testing

internal class DriverDragAndDropIntegrationTestBase<Configuration: DriverTestConfiguration>:
    DriverIntegrationTest<Configuration>
{
    func runDragAndDropTest(page: String) async throws {
        self.page = page

        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let sourceElement = try await driver.findElement(.css(.id("source")))
        let targetElement = try await driver.findElement(.css(.id("target")))

        try await driver.dragAndDrop(from: sourceElement, to: targetElement)

        let targetElementText = try await driver
            .getProperty(element: targetElement, propertyName: "innerText")
            .value?
            .stringValue

        #expect(targetElementText == "DROPPED!")
    }
}

@Suite("Chrome Driver Drag and Drop Integration Tests", .serialized)
internal final class ChromeDriverDragAndDropIntegrationTests:
    DriverDragAndDropIntegrationTestBase<ChromeTestConfiguration>
{
    @Test("Drag Element To Another (JavaScript)")
    func dragAndDropDraggableElementToAnother() async throws {
        try await runDragAndDropTest(page: "dragTarget.html")
    }

    @Test("Drag Element To Another (WebDriver Actions API)")
    func dragAndDropElementToAnother() async throws {
        try await runDragAndDropTest(page: "dragBox.html")
    }
}

@Suite("Firefox Driver Drag and Drop Integration Tests", .serialized)
internal final class FirefoxDriverDragAndDropIntegrationTests:
    DriverDragAndDropIntegrationTestBase<FirefoxTestConfiguration>
{
    @Test("Drag Element To Another (JavaScript)")
    func dragAndDropDraggableElementToAnother() async throws {
        try await runDragAndDropTest(page: "dragTarget.html")
    }

    @Test("Drag Element To Another (WebDriver Actions API)")
    func dragAndDropElementToAnother() async throws {
        try await runDragAndDropTest(page: "dragBox.html")
    }
}
