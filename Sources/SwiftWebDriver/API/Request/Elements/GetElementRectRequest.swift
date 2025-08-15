// GetElementRectRequest.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import AsyncHTTPClient
import Foundation
import NIO
import NIOHTTP1

/// Request to retrieve the rectangle (position and size) of a DOM element using the WebDriver API.
///
/// Conforms to `RequestType` to be used with `APIClient`.
internal struct GetElementRectRequest: RequestType {
    /// Response type returned by this request.
    public typealias Response = GetElementRectResponse

    /// Base URL of the WebDriver server.
    public var baseURL: URL

    /// Session ID of the active WebDriver session.
    public var sessionId: String

    /// WebDriver element ID for which the rectangle is requested.
    public var elementId: String

    /// Endpoint path for retrieving the element rectangle.
    public var path: String { "session/\(sessionId)/element/\(elementId)/rect" }

    /// HTTP method used for this request (`GET`).
    public var method: HTTPMethod = .GET

    /// HTTP headers for the request (empty by default).
    public var headers: HTTPHeaders = [:]

    /// HTTP request body (none required for this request).
    public var body: HTTPClient.Body? { nil }
}
