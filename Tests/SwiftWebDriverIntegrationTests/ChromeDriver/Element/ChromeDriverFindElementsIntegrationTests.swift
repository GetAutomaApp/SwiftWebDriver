// ChromeDriverFindElementsIntegrationTests.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

@testable import SwiftWebDriver
import Testing

@Suite("Chrome Driver Find Elements Tests", .serialized)
internal class ChromeDriverFindElementsIntegrationTests: ChromeDriverTest {
    @Test("Get Elements CSS Elements")
    public func getElementsCSSElements() async throws {
        page = "findElementsTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let expectedElements1Count = 1
        let expectedElements2Count = 2

        let elements = try await driver.findElements(.css(.class("classElement1")))
        #expect(elements.count == expectedElements1Count)

        let elements2 = try await driver.findElements(.css(.class("classElement2")))
        #expect(elements2.count == expectedElements2Count)

        let idElement1 = try await driver.findElements(.css(.id("idElement1")))
        #expect(idElement1.count == expectedElements1Count)

        let idElement2 = try await driver.findElements(.css(.id("idElement2")))
        #expect(idElement2.count == expectedElements2Count)

        let nameElement1 = try await driver.findElements(.css(.name("nameElement1")))
        #expect(nameElement1.count == expectedElements1Count)

        let nameElement2 = try await driver.findElements(.css(.name("nameElement2")))
        #expect(nameElement2.count == expectedElements2Count)
    }

    @Test("Get Elements By XPath")
    public func getElementsByXPath() async throws {
        page = "findElementsTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let xpathFirstLayerElementsCount = 9
        let xpathElements = try await driver
            .findElements(.xpath("/html/body/div"))

        #expect(xpathElements.count == xpathFirstLayerElementsCount)
    }

    @Test("Get Elements By Link Text")
    public func getElementsByLinkText() async throws {
        page = "findElementsTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let linkElements1Count = 1
        let linkElements2Count = 1

        let linkElement1 = try await driver
            .findElements(.linkText("1linkElement"))

        #expect(linkElement1.count == linkElements1Count)

        let linkElement2 = try await driver
            .findElements(.linkText("2linkElements"))

        #expect(linkElement2.count == linkElements2Count)
    }

    @Test("Get Elements By Partial Link Text")
    public func getElementsByPartialLink() async throws {
        let partialLinkElements1Count = 1
        let partialLinkElements2Count = 2

        page = "findElementsTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let linkElement1 = try await driver
            .findElements(.partialLinkText("1"))

        #expect(linkElement1.count == partialLinkElements1Count)

        let linkElement2 = try await driver
            .findElements(.partialLinkText("2"))

        #expect(linkElement2.count == partialLinkElements2Count)
    }

    @Test("Get Elements By Tag Name")
    public func getElementByTagName() async throws {
        let tagElements1Count = 1
        let tagElements2Count = 2

        page = "findElementsTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let tagElement1 = try await driver
            .findElements(.tagName("p"))

        #expect(tagElement1.count == tagElements1Count)

        let tagElement2 = try await driver
            .findElements(.tagName("b"))

        #expect(tagElement2.count == tagElements2Count)
    }

    deinit {
        // Add deinit logic here
    }
}
