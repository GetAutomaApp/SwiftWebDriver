import Foundation
import AsyncHTTPClient
import NIOHTTP1
import NIO

internal struct PostNavigationRequest: RequestType {

    typealias Response = PostNavigationResponse

    var baseURL: URL

    var sessionId: String

    let requestURL: String

    var path: String {
        "session/\(sessionId)/url"
    }

    var method: HTTPMethod = .POST

    var headers: HTTPHeaders = [:]

    var body: HTTPClient.Body? {

        let requestBody = PostNavigationRequest
            .RequestBody(url: requestURL)

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(requestBody)

        guard let data = data else {
            return nil
        }

        return .data(data)
    }

}

// MARK: - PostNavigationRequest.RequestBody
extension PostNavigationRequest {
    struct RequestBody: Codable {
        let url: String
    }
}
