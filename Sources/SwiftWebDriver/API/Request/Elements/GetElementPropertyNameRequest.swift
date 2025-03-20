import Foundation
import AsyncHTTPClient
import NIOHTTP1
import NIO

internal struct GetElementPropertyNameRequest: RequestType {

    typealias Response = GetElementPropertyNameResponse

    var baseURL: URL

    var sessionId: String

    var elementId: String

    var propertyName: String

    var path: String {
        "session/\(sessionId)/element/\(elementId)/css/\(propertyName)"
    }

    var method: HTTPMethod = .GET

    var headers: HTTPHeaders = [:]

    var body: HTTPClient.Body?

}
