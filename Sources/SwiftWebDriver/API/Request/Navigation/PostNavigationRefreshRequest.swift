import Foundation
import AsyncHTTPClient
import NIOHTTP1
import NIO

internal struct PostNavigationRefreshRequest: RequestType {

    typealias Response = PostNavigationRefreshResponse

    var baseURL: URL

    var sessionId: String

    var path: String {
        "session/\(sessionId)/refresh"
    }

    var method: HTTPMethod = .POST

    var headers: HTTPHeaders = [:]

    var body: HTTPClient.Body? {

        let requestBody = PostNavigationRefreshRequest
            .RequestBody(additionalProp1: nil, additionalProp2: nil, additionalProp3: nil)

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
extension PostNavigationRefreshRequest {
    struct RequestBody: Codable {
        let additionalProp1: AdditionalProp?
        let additionalProp2: AdditionalProp?
        let additionalProp3: AdditionalProp?
    }
}

// MARK: - PostNavigationRequest.RequestBody.AdditionalProp
extension PostNavigationRefreshRequest.RequestBody {
    struct AdditionalProp: Codable {}
}
