import Foundation
import AsyncHTTPClient
import NIOHTTP1
import NIO

/// APIClient use RequestType
public protocol RequestType {

    /// convert response to Codable
    associatedtype Response: Codable

    /// The target's base `URL`.
    var baseURL: URL { get }

    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }

    /// request http method
    var method: NIOHTTP1.HTTPMethod { get }

    /// request http beaders
    var headers: NIOHTTP1.HTTPHeaders { get }

    /// request http body
    var body: HTTPClient.Body? { get }

}

extension RequestType {

    /// request full path
    var url: URL {
        baseURL.appendingPathComponent(path)
    }
}

extension HTTPClient {
    public func execute<R>(request: R, deadline: NIODeadline? = nil) -> EventLoopFuture<Response>  where R: RequestType {
        do {
            let request = try HTTPClient.Request(url: request.url, method: request.method, headers: request.headers, body: request.body)

            return self.execute(request: request, deadline: deadline)
        } catch {
            return self.eventLoopGroup.any().makeFailedFuture(error)
        }
    }
}
