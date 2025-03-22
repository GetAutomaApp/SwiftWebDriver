@testable import SwiftWebDriver
import Testing

@Suite("Chrome Driver Navigation Tests", .serialized)
class ChromeDriverNavigationTests: ChromeDriverTest {
    @Test("Get Navigation Title")
    func getNavigationTitle() async throws {
        page = "awaitTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        let title = try await driver.navigationTitle()
        #expect(title.value != nil)
        #expect(title.value == "expect title")
    }

    @Test("Wait Until Element Exists")
    func waitUntilElements() async throws {
        page = "awaitTestPage.html"
        try await driver.navigateTo(urlString: testPageURL.absoluteString)

        try await driver
            .findElement(.css(.id("startButton")))
            .click()

        let result = try await driver
            .waitUntil(.css(.id("asyncAddElement")), retryCount: 5, durationSeconds: 1)

        #expect(result)
    }
}
