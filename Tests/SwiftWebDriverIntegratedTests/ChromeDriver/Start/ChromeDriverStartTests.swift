//
//  ChromeDriverStartTests.swift
//
//
//  Created by ashizawa on 2022/06/10.
//

import XCTest
@testable import SwiftWebDriver

class ChromeDriverStartTests: XCTestCase, WebPageTestable {
    
    var pageEndPoint: String = ""
    
    
    let chromeOption = try! ChromeOptions(args: [
        Args(.headless),
        Args(.noSandbox),
        Args(.disableDevShmUsage)
    ])
    
    func testStartAndStop() async throws {
        do {
            guard let url = URL(string: webDriverURL) else {
                XCTFail()
                return
            }
            
            let driver = WebDriver(
                driver: ChromeDriver(
                    driverURL: url,
                    browserObject: chromeOption))


            defer {
                Task.detached {
                    do {
                        try await driver.stop()
                    } catch {
                        XCTFail(error.localizedDescription)
                    }
                }
            }

            let status = try await driver.status()
            XCTAssertNotEqual(status.value.message, "")
            let sessionId = try await driver.start()
            XCTAssertNotEqual(sessionId, "")
            
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
