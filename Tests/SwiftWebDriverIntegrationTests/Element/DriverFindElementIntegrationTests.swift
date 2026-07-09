// DriverFindElementIntegrationTests.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

@testable import SwiftWebDriver
import Testing

internal class DriverFindElementIntegrationTestBase<Configuration: DriverTestConfiguration>:
    DriverIntegrationTest<Configuration>
{
    func runGetElementCSSElementTest() async throws {
        page = "index.html"
        try await driver.navigateTo(url: testPageURL)

        let classText = try await driver
            .findElement(.css(.class("classElement")))
            .text()

        #expect(classText == "classElement")

        let idElement = try await driver
            .findElement(.css(.id("idElement")))
            .text()

        #expect(idElement == "idElement")

        let nameElement = try await driver
            .findElement(.css(.name("nameElement")))
            .text()

        #expect(nameElement == "nameElement")
    }

    func runGetElementByXPathTest() async throws {
        page = "index.html"
        try await driver.navigateTo(url: testPageURL)

        let inParentSingleElement = try await driver
            .findElement(.xpath("//*[@id=\"inParentSingleElement\"]"))
            .text()

        #expect(inParentSingleElement == "inParentSingleElement")
    }

    func runGetElementByLinkTextTest() async throws {
        page = "index.html"
        try await driver.navigateTo(url: testPageURL)

        let text = try await driver
            .findElement(.linkText("go to next page"))
            .text()

        #expect(text == "go to next page")
    }

    func runGetElementByPartialLinkTest() async throws {
        page = "index.html"
        try await driver.navigateTo(url: testPageURL)

        let text = try await driver
            .findElement(.partialLinkText("go"))
            .text()

        #expect(text == "go to next page")
    }

    func runGetElementByTagNameTest() async throws {
        page = "index.html"
        try await driver.navigateTo(url: testPageURL)

        let text = try await driver
            .findElement(.tagName("h1"))
            .text()

        #expect(text == "this is h1")
    }
}

@Suite("Chrome Driver Find Element Tests", .serialized)
internal final class ChromeDriverFindElementIntegrationTests:
    DriverFindElementIntegrationTestBase<ChromeTestConfiguration>
{
    @Test("Get Element By CSS Selector")
    func getElementCSSElement() async throws {
        try await runGetElementCSSElementTest()
    }

    @Test("Get Element By XPath")
    func getElementByXPath() async throws {
        try await runGetElementByXPathTest()
    }

    @Test("Get Element By Link Text")
    func getElementByLinkText() async throws {
        try await runGetElementByLinkTextTest()
    }

    @Test("Get Element By Partial Link")
    func getElementByPartialLink() async throws {
        try await runGetElementByPartialLinkTest()
    }

    @Test("Get Element By TagName")
    func getElementByTagName() async throws {
        try await runGetElementByTagNameTest()
    }
}

@Suite("Firefox Driver Find Element Tests", .serialized)
internal final class FirefoxDriverFindElementIntegrationTests:
    DriverFindElementIntegrationTestBase<FirefoxTestConfiguration>
{
    @Test("Get Element By CSS Selector")
    func getElementCSSElement() async throws {
        try await runGetElementCSSElementTest()
    }

    @Test("Get Element By XPath")
    func getElementByXPath() async throws {
        try await runGetElementByXPathTest()
    }

    @Test("Get Element By Link Text")
    func getElementByLinkText() async throws {
        try await runGetElementByLinkTextTest()
    }

    @Test("Get Element By Partial Link")
    func getElementByPartialLink() async throws {
        try await runGetElementByPartialLinkTest()
    }

    @Test("Get Element By TagName")
    func getElementByTagName() async throws {
        try await runGetElementByTagNameTest()
    }
}
