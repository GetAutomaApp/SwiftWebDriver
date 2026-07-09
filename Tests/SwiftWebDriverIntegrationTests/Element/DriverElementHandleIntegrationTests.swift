// DriverElementHandleIntegrationTests.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

@testable import SwiftWebDriver
import Testing

internal class DriverElementHandleIntegrationTestBase<Configuration: DriverTestConfiguration>:
    DriverIntegrationTest<Configuration>
{
    func runClickButtonTest() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let button = try await driver.findElement(.css(.id("button")))
        try await button.click()

        #expect(try await button.text() == "clicked!")
    }

    func runDoubleClickButtonTest() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let button = try await driver.findElement(.css(.id("doubleclick")))
        try await button.doubleClick()

        #expect(try await button.text() == "ii")
    }

    func runDragElementToAnotherTest() async throws {
        page = "dragBox.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let source = try await driver.findElement(.css(.id("source")))
        let target = try await driver.findElement(.css(.id("target")))

        try await source.dragAndDrop(to: target)

        let targetText = try await driver
            .getProperty(element: target, propertyName: "innerText")
            .value?
            .stringValue

        #expect(targetText == "DROPPED!", "Target text should be 'DROPPED!' after pointer drag")
    }

    func runGetAttributeTest() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let inputElement = try await driver.findElement(.css(.id("attribute")))
        let attribute = try await inputElement.attribute(name: "value")

        #expect(attribute == "expect attribute")
    }

    func runGetRectTest() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let element = try await driver.findElement(.css(.id("rect")))
        let rect = try await element.rect()

        #expect(rect.height == 100)
        #expect(rect.xPosition > 5)
        #expect(rect.yPosition > 5)
        #expect(rect.width == 100)
    }

    func runClearElementTest() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let inputElement = try await driver.findElement(.css(.id("clearInputValue")))
        try await inputElement.clear()

        #expect(try await inputElement.text() == "")
    }

    func runSendKeyTest() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let element = try await driver.findElement(.css(.id("sendValue")))
        try await element.send(value: "newValue")

        let text = try await driver
            .execute("return document.querySelector('#sendValue').value")
            .value?
            .stringValue

        #expect(text == "newValue")
    }

    func runSendChordTest() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let element = try await driver.findElement(.css(.id("sendValue")))
        try await element.send(value: "newValue")

        let text = try await driver
            .execute("return document.querySelector('#sendValue').value")
            .value?
            .stringValue

        #expect(text == "newValue")

        try await element.sendKeys(keys: .CONTROL, characters: "a")
        try await element.sendKeys(keys: .BACKSPACE)

        let newText = try await driver
            .execute("return document.querySelector('#sendValue').value")
            .value?
            .stringValue

        #expect(newText == "")
    }

    func runGetScreenshotTest() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let element = try await driver.findElement(.css(.id("sendValue")))
        let elementScreenshot = try await element.screenshot()
        let data = elementScreenshot.data(using: .utf8)

        #expect(data != nil)
    }

    func runThrowStaleErrorTest() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let element = try await driver.findElement(.css(.id("willDelete")))
        try await element.click()

        try await Task.sleep(for: .seconds(3))

        do {
            try await element.click()
            #expect(Bool(false))
        } catch {
            #expect(Bool(true))
        }
    }
}

@Suite("Chrome Driver Element Handles", .serialized)
internal final class ChromeDriverElementHandleIntegrationTests:
    DriverElementHandleIntegrationTestBase<ChromeTestConfiguration>
{
    @Test("Click Button")
    func clickButton() async throws {
        try await runClickButtonTest()
    }

    @Test("Double Click Button")
    func doubleClickButton() async throws {
        try await runDoubleClickButtonTest()
    }

    @Test("Drag Element To Another")
    func dragElementToAnother() async throws {
        try await runDragElementToAnotherTest()
    }

    @Test("Get Element Attributes")
    func getAttribute() async throws {
        try await runGetAttributeTest()
    }

    @Test("Get Element Rect")
    func getRect() async throws {
        try await runGetRectTest()
    }

    @Test("Clear Element")
    func clearElement() async throws {
        try await runClearElementTest()
    }

    @Test("Send Key")
    func sendKey() async throws {
        try await runSendKeyTest()
    }

    @Test("Send Chord")
    func sendChord() async throws {
        try await runSendChordTest()
    }

    @Test("Get Screenshot")
    func getScreenshot() async throws {
        try await runGetScreenshotTest()
    }

    @Test("Fail any operation if element becomes stale")
    func throwStaleError() async throws {
        try await runThrowStaleErrorTest()
    }
}

@Suite("Firefox Driver Element Handles", .serialized)
internal final class FirefoxDriverElementHandleIntegrationTests:
    DriverElementHandleIntegrationTestBase<FirefoxTestConfiguration>
{
    @Test("Click Button")
    func clickButton() async throws {
        try await runClickButtonTest()
    }

    @Test("Double Click Button")
    func doubleClickButton() async throws {
        try await runDoubleClickButtonTest()
    }

    @Test("Drag Element To Another")
    func dragElementToAnother() async throws {
        try await runDragElementToAnotherTest()
    }

    @Test("Get Element Attributes")
    func getAttribute() async throws {
        try await runGetAttributeTest()
    }

    @Test("Get Element Rect")
    func getRect() async throws {
        try await runGetRectTest()
    }

    @Test("Clear Element")
    func clearElement() async throws {
        try await runClearElementTest()
    }

    @Test("Send Key")
    func sendKey() async throws {
        try await runSendKeyTest()
    }

    @Test("Send Chord")
    func sendChord() async throws {
        try await runSendChordTest()
    }

    @Test("Get Screenshot")
    func getScreenshot() async throws {
        try await runGetScreenshotTest()
    }

    @Test("Fail any operation if element becomes stale")
    func throwStaleError() async throws {
        try await runThrowStaleErrorTest()
    }
}
