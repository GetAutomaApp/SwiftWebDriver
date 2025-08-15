// PostExecuteRequest.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import AsyncHTTPClient
import Foundation
import NIO
import NIOHTTP1

/// A WebDriver request for executing JavaScript in the context of the browser.
///
/// `PostExecuteRequest` can execute JavaScript either synchronously or asynchronously
/// depending on the `type` parameter. The request sends the script and optional arguments
/// to the WebDriver session and returns a `PostExecuteResponse` containing the result.
///
/// Conforms to `RequestType` for use with `APIClient`.
internal struct PostExecuteRequest: RequestType {
    // MARK: - Associated Types

    /// The expected response type returned by executing the JavaScript snippet.
    public typealias Response = PostExecuteResponse

    // MARK: - Properties

    /// The base URL of the WebDriver server.
    public var baseURL: URL

    /// The active WebDriver session identifier.
    public var sessionId: String

    /// Determines whether the JavaScript is executed synchronously or asynchronously.
    public var type: DevToolTypes.JavascriptExecutionTypes

    /// The request path relative to `baseURL`.
    ///
    /// - If `type` is `.sync`, the request uses `session/{sessionId}/execute/sync`.
    /// - Otherwise, it uses `session/{sessionId}/execute/async`.
    public var path: String {
        switch type {
        case .sync:
            "session/\(sessionId)/execute/sync"
        default:
            "session/\(sessionId)/execute/async"
        }
    }

    /// The JavaScript snippet and its arguments to execute.
    public let javascriptSnippet: RequestBody

    /// The HTTP method used for this request.
    ///
    /// Always `.POST` because WebDriver requires POST for JavaScript execution.
    public var method: HTTPMethod = .POST

    /// The HTTP headers for this request.
    ///
    /// Defaults to an empty header set.
    public var headers: HTTPHeaders = [:]

    /// The HTTP request body containing the encoded JavaScript snippet and arguments.
    ///
    /// Returns `nil` if encoding fails.
    public var body: HTTPClient.Body? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        guard let data = try? encoder.encode(javascriptSnippet) else {
            return nil
        }

        return .data(data)
    }
}

// MARK: - Nested Types

internal extension PostExecuteRequest {
    /// The body of the JavaScript execution request.
    ///
    /// Contains the script string and an array of arguments, which are type-erased
    /// using `AnyEncodable` to allow any `Encodable` value to be passed to the script.
    struct RequestBody: Encodable {
        /// The JavaScript code to execute.
        public let script: String

        /// The arguments to pass to the script.
        public let args: [AnyEncodable]
    }
}
