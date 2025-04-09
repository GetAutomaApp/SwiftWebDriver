// PostNavigationRequest.swift
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

internal struct PostNavigationRequest: RequestType {
    public typealias Response = PostNavigationResponse

    public var baseURL: URL

    public var sessionId: String

    public let requestURL: String

    public var path: String {
        "session/\(sessionId)/url"
    }

    public var method: HTTPMethod = .POST

    public var headers: HTTPHeaders = [:]

    public var body: HTTPClient.Body? {
        let requestBody = Self
            .RequestBody(url: requestURL)

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(requestBody)

        guard let data else {
            return nil
        }

        return .data(data)
    }
}

// MARK: - PostNavigationRequest.RequestBody

internal extension PostNavigationRequest {
    struct RequestBody: Codable {
        public let url: String
    }
}
