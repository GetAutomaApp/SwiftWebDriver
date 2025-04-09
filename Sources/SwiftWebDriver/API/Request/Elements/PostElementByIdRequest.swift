// PostElementByIdRequest.swift
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

internal struct PostElementByIdRequest: RequestType {
    public typealias Response = PostElementByIdResponse

    public var baseURL: URL

    public var sessionId: String

    public var elementId: String

    public var path: String {
        "session/\(sessionId)/element/\(elementId)/element"
    }

    public var method: HTTPMethod = .POST

    public var cssSelector: LocatorSelector

    public var headers: HTTPHeaders = [:]

    public var body: HTTPClient.Body? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(cssSelector)

        guard let data else {
            return nil
        }

        return .data(data)
    }
}
