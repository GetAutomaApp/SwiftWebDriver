import Foundation
import AsyncHTTPClient
import NIOHTTP1
import NIO

internal struct GetElementNamePropertyRequest: RequestType {

    typealias Response = GetElementNamePropertyResponse

    var baseURL: URL

    var sessionId: String

    var elementId: String

    var name: String

    var path: String {
        "session/\(sessionId)/element/\(elementId)/prorety/\(name)"
    }

    var method: HTTPMethod = .GET

    var headers: HTTPHeaders = [:]

    var body: HTTPClient.Body?

}
