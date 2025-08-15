// APIClient.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import AsyncHTTPClient
import Foundation
import NIO
import NIOFoundationCompat
import NIOHTTP1

internal enum APIResponseError: Error, Codable {
    case massage
}

internal enum APIError: Error {
    case decodingKeyNotFound
    case responseBodyIsNil
    case responseStatsFailed(statusCode: HTTPResponseStatus)
}

internal struct APIClient {
    private let httpClient = HTTPClient(eventLoopGroupProvider: .singleton)

    /// The shared singleton instance of `APIClient`.
    ///
    /// Use this when you need a shared HTTP client for sending requests to
    /// the WebDriver server or other API endpoints without creating a new
    /// instance each time.
    public static let shared = Self()

    /// Sends a request to the API and decodes the response into a `Codable` model.
    ///
    /// This method executes the given `RequestType` using the underlying
    /// `AsyncHTTPClient` and decodes the result into the associated `Response`
    /// type declared by the request. If the server responds with a non-OK
    /// status code, the response is checked for a `SeleniumError` and thrown
    /// if present; otherwise, an `APIError.responseStatsFailed` is thrown.
    ///
    /// - Parameter request: The request to send. Must conform to `RequestType`
    ///   and have a `Codable` response type.
    /// - Returns: An `EventLoopFuture` that will succeed with the decoded
    ///   response object or fail with an error.
    ///
    /// - Throws:
    ///   - `SeleniumError` if the server returns a known WebDriver error.
    ///   - `APIError.responseStatsFailed` if the status code indicates failure.
    ///   - `APIError.responseBodyIsNil` if no response body is returned.
    ///   - Any `DecodingError` if the response cannot be decoded.
    public func request<R>(_ request: R) -> EventLoopFuture<R.Response> where R: RequestType {
        httpClient.execute(request: request).flatMapResult { response -> Result<R.Response, Error> in
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

    /// Sends a request to the API and decodes the response into a `Codable` model, using Swift concurrency.
    ///
    /// This is the async/await variant of `request(_:)`, returning the decoded
    /// response directly rather than wrapping it in an `EventLoopFuture`.
    ///
    /// - Parameter request: The request to send. Must conform to `RequestType`
    ///   and have a `Codable` response type.
    /// - Returns: The decoded response object.
    ///
    /// - Throws:
    ///   - `SeleniumError` if the server returns a known WebDriver error.
    ///   - `APIError.responseStatsFailed` if the status code indicates failure.
    ///   - `APIError.responseBodyIsNil` if no response body is returned.
    ///   - Any `DecodingError` if the response cannot be decoded.
    @discardableResult
    public func request<R>(_ request: R) async throws -> R.Response where R: RequestType {
        try await self.request(request).get()
    }
}
