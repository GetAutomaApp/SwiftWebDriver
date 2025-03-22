import Foundation
import AsyncHTTPClient
import NIOHTTP1
import NIO

internal struct GetElementScreenShotRequest: RequestType {

    typealias Response = GetElementScreenShotResponse

    var baseURL: URL

    var sessionId: String

    var elementId: String

    var path: String {
        "session/\(sessionId)/element/\(elementId)/screenshot"
    }

    var method: HTTPMethod = .GET

    var headers: HTTPHeaders = [:]

    var body: HTTPClient.Body?

}
