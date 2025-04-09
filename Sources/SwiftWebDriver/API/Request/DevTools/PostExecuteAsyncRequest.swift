// PostExecuteAsyncRequest.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

import AsyncHTTPClient
import Foundation
import NIO
import NIOHTTP1

internal struct PostExecuteAsyncRequest: RequestType {
    public typealias Response = PostExecuteResponse

    public var baseURL: URL

    public var sessionId: String

    public var path: String {
        "session/\(sessionId)/execute/async"
    }

    public let javascriptSnippet: RequestBody

    public var method: HTTPMethod = .POST

    public var headers: HTTPHeaders = [:]

    public var body: HTTPClient.Body? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(javascriptSnippet)

        guard let data else {
            return nil
        }

        return .data(data)
    }
}

internal extension PostExecuteAsyncRequest {
    struct RequestBody: Codable {
        public let script: String
        public let args: [String]
    }
}
