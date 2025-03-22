@testable import SwiftWebDriver
import Testing

@Suite("Chrome Driver Start Tests", .serialized)
class ChromeDriverStartTests: ChromeDriverTest {
    @Test("Start & Stop")
    func startAndStop() async throws {
        let status = try await driver.status()
        #expect(status.value.message != "")
        let sessionId = try await driver.start()
        #expect(sessionId != "")
    }
}
