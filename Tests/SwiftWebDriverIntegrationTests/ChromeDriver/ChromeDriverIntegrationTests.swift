import Foundation

protocol WebPageTestableProtocol {
    var webDriverURL: String { get }
    var testPageBaseURL: URL { get }
    var pageEndPoint: String { get }
    var testPageURL: URL { get }
    var testPageURLString: String { get }
}

extension WebPageTestableProtocol {
    var webDriverURL: String { "http://selenium:4444" }
    
    var testPageBaseURL: URL {
        URL(string: "http://httpd")!
    }
    
    var testPageURL: URL {
        return testPageBaseURL.appendingPathComponent(pageEndPoint)
    }
    
    var testPageURLString: String {
        testPageURL.absoluteString
    }
}
