import Foundation
import AsyncHTTPClient
@preconcurrency import NIOHTTP1
import NIOFoundationCompat
import NIO

enum APIResponseError: Error, Codable {
    case massage
}

enum APIError: Error {
    case responseStatsFailed(statusCode: HTTPResponseStatus)
    case responseBodyIsNil
    case decodingKeyNotFound
}

internal struct APIClient {

    private let httpClient = HTTPClient(eventLoopGroupProvider: .singleton)

    public static let shared = APIClient()

    private init() {}

    /// Request send To API and Perse Codable Models
    /// - Parameter request: RequestType
    /// - Returns: EventLoopFuture<RequestType.Response>
    internal func request<R>(_ request: R) -> EventLoopFuture<R.Response>  where R: RequestType{
        return httpClient.execute(request: request).flatMapResult { response -> Result<R.Response, Error>  in

            guard response.status == .ok else {
                if
                    let buffer = response.body,
                    let error = try? JSONDecoder().decode(SeleniumError.self, from: buffer)
                    {
                        print(error.localizedDescription)
                        return .failure(error)
                    }

                return .failure(APIError.responseStatsFailed(statusCode: response.status))
            }

            guard let buffer = response.body else {
                return .failure(APIError.responseBodyIsNil)
            }

            do {
                let response = try JSONDecoder().decode(R.Response.self, from: buffer)
                return .success(response)
            } catch {
                return .failure(error)
            }
        }
    }

    /// Request send To API and Perse Codable Models
    /// - Parameter request: RequestType
    /// - Returns: EventLoopFuture<RequestType.Response>
    internal func request<R>(_ request: R) async throws -> R.Response  where R: RequestType{
        return try await self.request(request).get()
    }
}
