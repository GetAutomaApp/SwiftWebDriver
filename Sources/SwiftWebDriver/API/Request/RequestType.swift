// RequestType.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import AsyncHTTPClient
import Foundation
import NIO
import NIOHTTP1

/// APIClient use RequestType
public protocol RequestType {
    /// convert response to Codable
    associatedtype Response: ResponseType

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

internal extension RequestType {
    /// request full path
    var url: URL {
        baseURL.appendingPathComponent(path)
    }
}

internal extension HTTPClient {
    func execute(request: some RequestType, deadline: NIODeadline? = nil) -> EventLoopFuture<Response> {
        do {
            let request = try HTTPClient.Request(
                url: request.url,
                method: request.method,
                headers: request.headers,
                body: request.body
            )

            return execute(request: request, deadline: deadline)
        } catch {
            return eventLoopGroup.any().makeFailedFuture(error)
        }
    }
}
