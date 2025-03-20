//
//  ChromeDriverElementHandleTests.swift
//  swift-webdriver
//
//  Created by Simon Ferns on 3/17/25.
//
import Testing
@testable import SwiftWebDriver

@Suite("Chrome Driver Element Handles", .serialized)
class ChromeDriverElementHandleTests: ChromeDriverTest {
    @Test("Click Button") func clickButton() async throws {
        page = "elementHandleTestPage.html"

        try await driver.navigateTo(urlString: testPageURL.absoluteString)
        let button = try await driver.findElement(.css(.id("button")))
        try await button.click()
        let test = try await button.text()
        #expect(test == "clicked!")
    }

    @Test("Get Element Attributes") func getAttribute() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let inputElement = try await driver
            .findElement(.css(.id("attribute")))
        let attribute = try await inputElement.attribute(name: "value")
        #expect(attribute == "expect attribute")
    }

    @Test("Clear Element") func clearElement() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let inputElement = try await driver
            .findElement(.css(.id("clearInputValue")))

        try await inputElement.clear()

        let text = try await inputElement.text()
        #expect(text == "")
    }

    @Test("Send Key") func sendKey() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)
        let element = try await driver.findElement(.css(.id("sendValue")))
        try await element.send(value: "newValue")
    }

    @Test("Get Screenshot") func getScreenshot() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)
        let element = try await driver.findElement(.css(.id("sendValue")))
        let elementScreenshot = try await element.screenshot()
        let data = elementScreenshot.data(using: .utf8)
        #expect(data != nil)
    }

    @Test("Fail any operation if element becomes stale") func throwStaleError() async throws {
        page = "elementHandleTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)
        let element = try await driver.findElement(.css(.id("willDelete")))
        try await element.click()
        try await Task.sleep(nanoseconds: 3_000_000_000)

        do {
            try await element.click()
            #expect(Bool(false))
        } catch {}
    }
}
