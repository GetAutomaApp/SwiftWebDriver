@testable import SwiftWebDriver
import Testing

@Suite("Chrome Driver Special Keys", .serialized)
class ChromeDriverSpecialKeysTests: ChromeDriverTest {
    @Test("Tab Should Cycle Input Elements Focus") func tabCycleInputElementFocus() async throws {
        page = "testSpecialKeys.html"

        try await driver.navigateTo(url: testPageURL)
        let inputElement = try await driver.findElement(.css(.id("input1")))
        try await inputElement.send(value: .TAB)
        try await Task.sleep(for: .seconds(1))
        let activeElement = try await driver.getActiveElement()
        #expect(try await activeElement.attribute(name: "id") == "input2")
    }
}
