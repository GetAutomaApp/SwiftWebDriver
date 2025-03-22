import AsyncHTTPClient
import Foundation
import NIO
import NIOHTTP1

struct PostElementSendValueRequest: RequestType {
    typealias Response = PostElementSendValueResponse

    var baseURL: URL

    var sessionId: String

    var elementId: String

    var path: String {
        "session/\(sessionId)/element/\(elementId)/value"
    }

    let method: HTTPMethod = .POST

    var text: String

    var headers: HTTPHeaders = [:]

    var body: HTTPClient.Body? {
        let reqeustBody = PostElementSendValueRequest
            .RequestBody(text: text)

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(reqeustBody)

        guard let data = data else {
            return nil
        }

        return .data(data)
    }
}

extension PostElementSendValueRequest {
    struct RequestBody: Codable {
        let text: String
    }
}
