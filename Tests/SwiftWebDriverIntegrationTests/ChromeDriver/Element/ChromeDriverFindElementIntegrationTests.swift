//
//  ChromeDriverFindElementTests.swift
//
//
//  Created by ashizawa on 2022/06/10.
//

import Testing
@testable import SwiftWebDriver

@Suite("Chrome Driver Element Tests", .serialized)
class ChromeDriverElementTests: ChromeDriverTest {
    @Test("Get Element By CSS Selector") func getElementCSSElement() async throws {
        page = "index.html"
        try await driver.navigateTo(url: testPageURL)

        let classText = try await driver.findElement(.css(.class("classElement"))).text()
        #expect(classText == "classElement")

        let idElement = try await driver.findElement(.css(.id("idElement"))).text()
        #expect(idElement == "idElement")

        let nameElement = try await driver.findElement(.css(.name("nameElement"))).text()
        #expect(nameElement == "nameElement")

    }

    @Test("Get Element By XPath") func getElementByXPath() async throws {
        page = "index.html"
        try await driver.navigateTo(url: testPageURL)

        let inParentSingleElement = try await driver.findElement(.xpath("//*[@id=\"inParentSingleElement\"]")).text()
        #expect(inParentSingleElement == "inParentSingleElement")
    }

    @Test("Get Element By Link Text") func getElementByLinkText() async throws {
        page = "index.html"
        try await driver.navigateTo(url: testPageURL)

        let text = try await driver
            .findElement(.linkText("go to next page"))
            .text()
        #expect(text == "go to next page")
    }

    @Test("Get Element By Partial Link") func getElementByParticalLink() async throws {
        page = "index.html"
        try await driver.navigateTo(url: testPageURL)

        let text = try await driver
            .findElement(.partialLinkText("go"))
            .text()

        #expect(text == "go to next page")
    }

    @Test("Get Element By TagName") func getElementByTagName() async throws {
        page = "index.html"
        try await driver.navigateTo(url: testPageURL)

        let text = try await driver
            .findElement(.tagName("h1"))
            .text()
        #expect(text == "this is h1")
    }
}
