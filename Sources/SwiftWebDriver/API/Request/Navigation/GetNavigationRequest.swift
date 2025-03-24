import Foundation
import AsyncHTTPClient
import NIOHTTP1
import NIO

internal struct GetNavigationRequest: RequestType {

    typealias Response = GetNavigationResponse

    var baseURL: URL

    var sessionId: String

    var path: String {
        "session/\(sessionId)/url"
    }

    var method: HTTPMethod = .GET

    var headers: HTTPHeaders = [:]

    var body: HTTPClient.Body?

}
