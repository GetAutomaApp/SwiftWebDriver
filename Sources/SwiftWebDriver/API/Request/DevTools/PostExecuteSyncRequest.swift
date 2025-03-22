import Foundation
import AsyncHTTPClient
import NIOHTTP1
import NIO

struct PostExecuteAsyncRequest: RequestType {
    typealias Response = PostExecuteResponse

    var baseURL: URL

    var sessionId: String

    var path: String {
        "session/\(sessionId)/execute/async"
    }

    let javascriptSnippet: RequestBody

    var method: HTTPMethod = .POST

    var headers: HTTPHeaders = [:]

    var body: HTTPClient.Body? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(javascriptSnippet)

        guard let data = data else {
            return nil
        }

        return .data(data)
    }

}


extension PostExecuteAsyncRequest {
    struct RequestBody: Codable {
        let script: String
        let args: [String]
    }
}

public enum ExecutionTypes {
    case sync, async
}
