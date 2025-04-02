// APIClient.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

import AsyncHTTPClient
import Foundation
import NIO
import NIOFoundationCompat
import NIOHTTP1

enum APIResponseError: Error, Codable {
    case massage
}

enum APIError: Error {
    case responseStatsFailed(statusCode: HTTPResponseStatus)
    case responseBodyIsNil
    case decodingKeyNotFound
}

struct APIClient {
    private let httpClient = HTTPClient(eventLoopGroupProvider: .singleton)

    public static let shared = APIClient()

    private init() {}

    /// Request send To API and Parse Codable Models
    /// - Parameter request: RequestType
    /// - Returns: EventLoopFuture<RequestType.Response>
    func request<R>(_ request: R) -> EventLoopFuture<R.Response> where R: RequestType {
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

    /// Request send To API and Perse Codable Models
    /// - Parameter request: RequestType
    /// - Returns: EventLoopFuture<RequestType.Response>
    @discardableResult
    func request<R>(_ request: R) async throws -> R.Response where R: RequestType {
        try await self.request(request).get()
    }
}
