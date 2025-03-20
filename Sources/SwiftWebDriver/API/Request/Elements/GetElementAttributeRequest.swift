import Foundation
import AsyncHTTPClient
import NIOHTTP1
import NIO

internal struct GetElementAttributeRequest: RequestType {

    typealias Response = GetElementAttributeResponse

    var baseURL: URL

    var sessionId: String

    var elementId: String

    var name: String

    var path: String {
        "session/\(sessionId)/element/\(elementId)/attribute/\(name)"
    }

    var method: HTTPMethod = .GET

    var headers: HTTPHeaders = [:]

    var body: HTTPClient.Body?

}
