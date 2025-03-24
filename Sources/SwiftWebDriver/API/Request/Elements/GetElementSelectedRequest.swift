import Foundation
import AsyncHTTPClient
import NIOHTTP1
import NIO

internal struct GetElementSelectedRequest: RequestType {

    typealias Response = GetSessionActiveElementResponse

    var baseURL: URL

    var sessionId: String

    var elementId: String

    var path: String {
        "session/\(sessionId)/element/\(elementId)/selected"
    }

    var method: HTTPMethod = .GET

    var headers: HTTPHeaders = [:]

    var body: HTTPClient.Body?

}
