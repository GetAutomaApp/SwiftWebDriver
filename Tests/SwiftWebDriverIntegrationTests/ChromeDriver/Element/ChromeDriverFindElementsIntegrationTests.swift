@testable import SwiftWebDriver
import Testing

@Suite("Chrome Driver Elements Tests", .serialized)
class ChromeDriverElementsTests: ChromeDriverTest {
    @Test("Get Elements CSS Elements")
    func getElementsCSSElements() async throws {
        page = "findElementsTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let elements = try await driver.findElements(.css(.class("classElement1")))
        #expect(elements.count == 1)

        let elements2 = try await driver.findElements(.css(.class("classElement2")))
        #expect(elements2.count == 2)

        let idElement1 = try await driver.findElements(.css(.id("idElement1")))
        #expect(idElement1.count == 1)

        let idElement2 = try await driver.findElements(.css(.id("idElement2")))
        #expect(idElement2.count == 2)

        let nameElement1 = try await driver.findElements(.css(.name("nameElement1")))
        #expect(nameElement1.count == 1)

        let nameElement2 = try await driver.findElements(.css(.name("nameElement2")))
        #expect(nameElement2.count == 2)
    }

    @Test("Get Elements By XPath")
    func getElementsByXPath() async throws {
        page = "findElementsTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let xpathElements = try await driver
            .findElements(.xpath("/html/body/div"))

        #expect(xpathElements.count == 9)
    }

    @Test("Get Elements By Link Text")
    func getElementsByLinkText() async throws {
        page = "findElementsTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let linkElement1 = try await driver
            .findElements(.linkText("1linkElement"))

        #expect(linkElement1.count == 1)

        let linkElement2 = try await driver
            .findElements(.linkText("2linkElements"))

        #expect(linkElement2.count == 2)
    }

    @Test("Get Elements By Partial Link Text")
    func getElementsByPartialLink() async throws {
        page = "findElementsTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let linkElement1 = try await driver
            .findElements(.partialLinkText("1"))

        #expect(linkElement1.count == 1)

        let linkElement2 = try await driver
            .findElements(.partialLinkText("2"))

        #expect(linkElement2.count == 2)
    }

    @Test("Get Elements By Tag Name")
    func getElementByTagName() async throws {
        page = "findElementsTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let tagElement1 = try await driver
            .findElements(.tagName("p"))

        #expect(tagElement1.count == 1)

        let tagElement2 = try await driver
            .findElements(.tagName("b"))

        #expect(tagElement2.count == 2)
    }
}
