import Foundation
import AsyncHTTPClient
import NIOHTTP1
import NIO

internal struct PostElementsRequest: RequestType {

    typealias Response = PostElementsResponse

    var baseURL: URL

    var sessionId: String

    var path: String {
        "session/\(sessionId)/elements"
    }

    var method: HTTPMethod = .POST

    var cssSelector: LocatorSelector

    var headers: HTTPHeaders = [:]

    var body: HTTPClient.Body? {

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(cssSelector)

        guard let data = data else {
            return nil
        }

        return .data(data)
    }

}
