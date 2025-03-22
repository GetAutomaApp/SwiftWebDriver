
import Foundation
import NIOHTTP1
import AsyncHTTPClient

internal struct DeleteSessionRequest: RequestType {

    typealias Response = DeleteSessionResponse

    var baseURL: URL

    var sessionId: String

    var path: String {
        "session/\(sessionId)"
    }

    var method: HTTPMethod = .DELETE

    var headers: HTTPHeaders = [:]

    var body: HTTPClient.Body?

}
