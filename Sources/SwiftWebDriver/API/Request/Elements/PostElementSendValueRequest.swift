// PostElementSendValueRequest.swift
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

internal struct PostElementSendValueRequest: RequestType {
    public typealias Response = PostElementSendValueResponse

    public var baseURL: URL

    public var sessionId: String

    public var elementId: String

    public var path: String {
        "session/\(sessionId)/element/\(elementId)/value"
    }

    public let method: HTTPMethod = .POST

    public var text: String

    public var headers: HTTPHeaders = [:]

    public var body: HTTPClient.Body? {
        let reqeustBody = Self
            .RequestBody(text: text)

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(reqeustBody)

        guard let data else {
            return nil
        }

        return .data(data)
    }
}

internal extension PostElementSendValueRequest {
    struct RequestBody: Codable {
        public let text: String
    }
}
