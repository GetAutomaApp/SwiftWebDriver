// ChromeDriverElementHandleIntegrationTests.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

@testable import SwiftWebDriver
import Testing

@Suite("Chrome Driver Element Handles", .serialized)
internal class ChromeDriverElementHandleIntegrationTests: ChromeDriverTest {
    @Test("Click Button")
    public func clickButton() async throws {
        page = "elementHandleTestPage.html"

        try await driver.navigateTo(urlString: testPageURL.absoluteString)
        let button = try await driver.findElement(.css(.id("button")))
        try await button.click()
        let test = try await button.text()
        #expect(test == "clicked!")
    }

    @Test("Double Click Button")
    public func doubleClickButton() async throws {
        page = "elementHandleTestPage.html"

        try await driver.navigateTo(urlString: testPageURL.absoluteString)
        let button = try await driver.findElement(.css(.id("doubleclick")))
        try await button.doubleClick()
        let test = try await button.text()
        #expect(test == "ii")
    }

    @Test("Drag Element To Another")
    public func dragElementToAnother() async throws {
        page = "dragBox.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let source = try await driver.findElement(.css(.id("source")))
        let target = try await driver.findElement(.css(.id("target")))

        try await source.dragAndDrop(to: target)

        let targetText = try await driver.getProperty(element: target, propertyName: "innerText").value?.stringValue
        #expect(targetText == "DROPPED!", "Target text should be 'DROPPED!' after pointer drag")
    }

    @Test("Get Element Attributes")
    public func getAttribute() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let inputElement = try await driver
            .findElement(.css(.id("attribute")))
        let attribute = try await inputElement.attribute(name: "value")
        #expect(attribute == "expect attribute")
    }

    @Test("Get Element Rect")
    public func getRect() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let element = try await driver
            .findElement(.css(.id("rect")))

        let rect = try await element.rect()

        #expect(rect.height == 100)
        #expect(rect.x > 5)
        #expect(rect.y > 5)
        #expect(rect.width == 100)
    }

    @Test("Clear Element")
    public func clearElement() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let inputElement = try await driver
            .findElement(.css(.id("clearInputValue")))

        try await inputElement.clear()

        let text = try await inputElement.text()
        #expect(text == "")
    }

    @Test("Send Key")
    public func sendKey() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)
        let element = try await driver.findElement(.css(.id("sendValue")))
        try await element.send(value: "newValue")
        let text = try await driver.execute("return document.querySelector('#sendValue').value").value?.stringValue
        #expect(text == "newValue")
    }

    @Test("Get Screenshot")
    public func getScreenshot() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)
        let element = try await driver.findElement(.css(.id("sendValue")))
        let elementScreenshot = try await element.screenshot()
        let data = elementScreenshot.data(using: .utf8)
        #expect(data != nil)
    }

    @Test("Fail any operation if element becomes stale")
    public func throwStaleError() async throws {
        let sleepTotal = 3
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)
        let element = try await driver.findElement(.css(.id("willDelete")))
        try await element.click()

        try await Task.sleep(for: .seconds(sleepTotal))

        do {
            try await element.click()
            #expect(Bool(false))
        } catch {
            #expect(Bool(true))
        }
    }

    deinit {
        // Add deinit logic here
    }
}
