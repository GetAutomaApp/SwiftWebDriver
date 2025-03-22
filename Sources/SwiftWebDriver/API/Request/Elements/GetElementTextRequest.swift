import Foundation
import AsyncHTTPClient
import NIOHTTP1
import NIO

internal struct GetElementTextRequest: RequestType {

    typealias Response = GetElementTextResponse

    var baseURL: URL

    var sessionId: String

    var elementId: String

    var path: String {
        "session/\(sessionId)/element/\(elementId)/text"
    }

    var method: HTTPMethod = .GET

    var headers: HTTPHeaders = [:]

    var body: HTTPClient.Body?

}
