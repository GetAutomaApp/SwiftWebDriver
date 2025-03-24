import Foundation
import AsyncHTTPClient
import NIOHTTP1
import NIO

internal struct GetElementNameRequest: RequestType {

    typealias Response = GetElementNameResponse

    var baseURL: URL

    var sessionId: String

    var elementId: String

    var path: String {
        "session/\(sessionId)/element/\(elementId)/name"
    }

    var method: HTTPMethod = .GET

    var headers: HTTPHeaders = [:]

    var body: HTTPClient.Body?

}
