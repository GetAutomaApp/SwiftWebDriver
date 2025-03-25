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

struct PostElementByIdRequest: RequestType {
    typealias Response = PostElementByIdResponse

    var baseURL: URL

    var sessionId: String

    var elementId: String

    var path: String {
        "session/\(sessionId)/element/\(elementId)/element"
    }

    var method: HTTPMethod = .POST

    var cssSelector: LocatorSelector

    var headers: HTTPHeaders = [:]

    var body: HTTPClient.Body? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(cssSelector)

        guard let data else {
            return nil
        }

        return .data(data)
    }
}
