import Foundation
import NIOHTTP1
import AsyncHTTPClient

internal struct NewSessionRequest: RequestType {

    typealias Response = NewSessionResponse

    var baseURL: URL

    var path: String = "session"

    var method: HTTPMethod = .POST

    var headers: HTTPHeaders = HTTPHeaders(
        [
            ("Content-Type", "application/json")
        ]
    )

    let chromeOptions: ChromeOptions

    var body: HTTPClient.Body? {
        let requestBody = NewSessionRequest
            .RequestBody(
                capabilities: RequestBody.Capabilities(
                    alwaysMatch: RequestBody.Capabilities.AlwaysMatch(
                        chromeOptions: chromeOptions
                    )
                )
            )
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(requestBody)

        guard let data = data else {
            return nil
        }

        return .data(data)
    }
}

// MARK: - NewSessionRequest.RequestBody
extension NewSessionRequest {
    struct RequestBody: Codable {
        let capabilities: Capabilities
    }
}

// MARK: - NewSessionRequest.RequestBody.Capabilities
extension NewSessionRequest.RequestBody {

    struct Capabilities: Codable {
        let alwaysMatch: AlwaysMatch
        enum CodingKeys: String, CodingKey {
            case alwaysMatch = "alwaysMatch"
        }
    }
}


// MARK: - NewSessionRequest.RequestBody.Capabilities.AlwaysMatch
extension NewSessionRequest.RequestBody.Capabilities {
    struct AlwaysMatch: Codable {
        let chromeOptions: ChromeOptions

        enum CodingKeys: String, CodingKey {
            case chromeOptions = "goog:chromeOptions"
        }
    }
}
