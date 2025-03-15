//
//  ChromeDriverIntegratedTests.swift
//
//
//  Created by ashizawa on 2022/06/09.
//

import XCTest
@testable import SwiftWebDriver

protocol WebPageTestable {
    var webDriverURL: String { get }
    var testPageBaseURL: URL { get }
    var pageEndPoint: String { get }
    var testPageURL: URL { get }
    var testPageURLString: String { get }
}
extension WebPageTestable {
    var webDriverURL: String { "http://localhost:4444" }
    var testPageBaseURL: URL {
        URL(string: "https://example.com")!
    }
    var testPageURL: URL {
        return testPageBaseURL.appendingPathComponent(pageEndPoint)
    }
    
    var testPageURLString: String {
        testPageURL.absoluteString
    }
}

class ChromeDriverIntegratedTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
    }
}
