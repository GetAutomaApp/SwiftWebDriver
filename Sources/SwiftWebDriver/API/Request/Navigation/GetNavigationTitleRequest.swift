import Foundation
import AsyncHTTPClient
import NIOHTTP1
import NIO

internal struct GetNavigationTitleRequest: RequestType {

    typealias Response = GetNavigationTitleResponse

    var baseURL: URL

    var sessionId: String

    var path: String {
        "session/\(sessionId)/title"
    }

    var method: HTTPMethod = .GET

    var headers: HTTPHeaders = [:]

    var body: HTTPClient.Body?

}
