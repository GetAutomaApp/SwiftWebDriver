// DriverFindElementsIntegrationTests.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

@testable import SwiftWebDriver
import Testing

internal enum DriverFindElementsIntegration {}

internal class DriverFindElementsIntegrationTest<Configuration: DriverTestConfiguration>:
    DriverIntegrationTest<Configuration>
{
    internal func runGetElementsCSSElementsTest() async throws {
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

    internal func runGetElementsByXPathTest() async throws {
        page = "findElementsTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let xpathFirstLayerElementsCount = 9

        let xpathElements = try await driver.findElements(
            .xpath("/html/body/div")
        )

        #expect(xpathElements.count == xpathFirstLayerElementsCount)
    }

    internal func runGetElementsByLinkTextTest() async throws {
        page = "findElementsTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let linkElements1Count = 1
        let linkElements2Count = 2

        let linkElement1 = try await driver.findElements(
            .linkText("1linkElement")
        )

        #expect(linkElement1.count == linkElements1Count)

        let linkElement2 = try await driver.findElements(
            .linkText("2linkElements")
        )

        #expect(linkElement2.count == linkElements2Count)
    }

    internal func runGetElementsByPartialLinkTest() async throws {
        page = "findElementsTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let partialLinkElements1Count = 1
        let partialLinkElements2Count = 2

        let linkElement1 = try await driver.findElements(
            .partialLinkText("1")
        )

        #expect(linkElement1.count == partialLinkElements1Count)

        let linkElement2 = try await driver.findElements(
            .partialLinkText("2")
        )

        #expect(linkElement2.count == partialLinkElements2Count)
    }

    internal func runGetElementsByTagNameTest() async throws {
        page = "findElementsTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let tagElements1Count = 1
        let tagElements2Count = 2

        let tagElement1 = try await driver.findElements(
            .tagName("p")
        )

        #expect(tagElement1.count == tagElements1Count)

        let tagElement2 = try await driver.findElements(
            .tagName("b")
        )

        #expect(tagElement2.count == tagElements2Count)
    }

    deinit {}
}

@Suite("Chrome Driver Find Elements Tests", .serialized)
internal final class ChromeDriverFindElementsIntegrationTests:
    DriverFindElementsIntegrationTest<ChromeTestConfiguration>
{
    @Test("Get Elements CSS Elements")
    internal func getElementsCSSElements() async throws {
        try await runGetElementsCSSElementsTest()
    }

    @Test("Get Elements By XPath")
    internal func getElementsByXPath() async throws {
        try await runGetElementsByXPathTest()
    }

    @Test("Get Elements By Link Text")
    internal func getElementsByLinkText() async throws {
        try await runGetElementsByLinkTextTest()
    }

    @Test("Get Elements By Partial Link Text")
    internal func getElementsByPartialLink() async throws {
        try await runGetElementsByPartialLinkTest()
    }

    @Test("Get Elements By Tag Name")
    internal func getElementByTagName() async throws {
        try await runGetElementsByTagNameTest()
    }

    deinit {}
}

@Suite("Firefox Driver Find Elements Tests", .serialized)
internal final class FirefoxDriverFindElementsIntegrationTests:
    DriverFindElementsIntegrationTest<FirefoxTestConfiguration>
{
    @Test("Get Elements CSS Elements")
    internal func getElementsCSSElements() async throws {
        try await runGetElementsCSSElementsTest()
    }

    @Test("Get Elements By XPath")
    internal func getElementsByXPath() async throws {
        try await runGetElementsByXPathTest()
    }

    @Test("Get Elements By Link Text")
    internal func getElementsByLinkText() async throws {
        try await runGetElementsByLinkTextTest()
    }

    @Test("Get Elements By Partial Link Text")
    internal func getElementsByPartialLink() async throws {
        try await runGetElementsByPartialLinkTest()
    }

    @Test("Get Elements By Tag Name")
    internal func getElementByTagName() async throws {
        try await runGetElementsByTagNameTest()
    }

    deinit {}
}
