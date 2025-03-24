import Foundation
@testable import SwiftWebDriver

protocol ChromeDriverIntegrationTests {
    var driver: WebDriver<ChromeDriver> { get set }
    var testPageURL: URL { get }
    var baseUrl: String { get }
    var page: String { get set }
}

class ChromeDriverTest: ChromeDriverIntegrationTests {
    let baseUrl: String = "http://httpd"
    var testPageURL: URL {
        .init(string: "\(baseUrl)/\(page)")!
    }
    
    var page: String = "index.html"
    var driver: WebDriver<ChromeDriver>
    
    init() async throws {
        let driverURL = URL(string: "http://selenium:4444")!
        let chromeOptions = ChromeOptions(args: [
            Args(.disableDevShmUsage),
            Args(.noSandbox)
        ])
        
        // Initialize the WebDriver on the main actor
        self.driver = WebDriver(
            driver: ChromeDriver(
                driverURL: driverURL,
                browserObject: chromeOptions
            )
        )
        
        try await self.driver.start()
    }
}
