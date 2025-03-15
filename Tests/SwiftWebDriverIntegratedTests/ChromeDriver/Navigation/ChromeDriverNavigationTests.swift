//
//  ChromeDriverNavigationTests.swift
//
//
//  Created by ashizawa on 2022/06/10.
//

import XCTest
@testable import SwiftWebDriver

class ChromeDriverNavigationTests: XCTestCase, WebPageTestable {
    
    
    var pageEndPoint: String = "awaitTestPage.html"

    let chromeOption = try! ChromeOptions(args: [
        Args(.noSandbox),
        Args(.disableDevShmUsage)
    ])
    
    func testExecuteJavascript() async throws {
        guard let url = URL(string: webDriverURL) else {
            XCTFail()
            return
        }
        
        let driver = WebDriver(
            driver: ChromeDriver(
                driverURL: url,
                browserObject: chromeOption
            )
        )
        
        defer {
            Task.detached {
                do {
                    try await driver.stop()
                } catch {
                    XCTFail(error.localizedDescription)
                }
            }
        }
        
        
        do {
            try await driver.start()
            try await driver.navigateTo(urlString: testPageURLString)
            try await driver.waitUntil(.css(.name("h1")))
            try await driver.executeJavascriptSync("document.body.innerHTML = '<p>hello</p>'", args: [])
            try await Task.sleep(nanoseconds: 1 * 1_000_000_000 )
            let output = try await driver.executeJavascriptSync("return document.body.innerText", args: [])
            let output2 = try await driver.findElement(.tagName("p")).text()
            let output3 = try await driver.executeJavascriptSync("return 1 + 1", args: [])
            XCTAssertEqual("hello", output.value.stringValue)
            XCTAssertEqual("hello", output2)
            XCTAssertEqual(output3.value.doubleValue, 2)
            try await Task.sleep(nanoseconds: 10 * 1_000_000_000 )
            print(output)
            
        } catch {}
    }

    func testGetNavigationTitle() async throws {
        
        guard let url = URL(string: webDriverURL) else {
            XCTFail()
            return
        }

        let driver = WebDriver(
            driver: ChromeDriver(
                driverURL: url,
                browserObject: chromeOption
            )
        )

        defer {
            Task.detached {
                do {
                    try await driver.stop()
                } catch {
                    XCTFail(error.localizedDescription)
                }
            }
        }

        do {
            try await driver.start()
            try await driver.navigateTo(urlString: testPageURLString)
            let title = try await driver.navigationTitle()
            XCTAssertNotNil(title.value)
            XCTAssertEqual(title.value, "expect title")
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testWaitUntilElements() async {
        guard let url = URL(string: webDriverURL) else {
            XCTFail()
            return
        }

        let driver = WebDriver(
            driver: ChromeDriver(
                driverURL: url,
                browserObject: chromeOption
            )
        )

        defer {
            Task.detached {
                do {
                    try await driver.stop()
                } catch {
                    XCTFail(error.localizedDescription)
                }
            }
        }

        do {
            try await driver.start()
            try await driver.navigateTo(urlString: testPageURLString)

            try await driver
                .findElement(.css(.id("startButton")))
                .click()

            let result = try await driver
                .waitUntil(.css(.id("asyncAddElement")), retryCount: 5, durationSeconds: 1)

            XCTAssertTrue(result)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
