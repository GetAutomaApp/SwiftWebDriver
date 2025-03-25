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

struct PostNavigationRequest: RequestType {
    typealias Response = PostNavigationResponse

    var baseURL: URL

    var sessionId: String

    let requestURL: String

    var path: String {
        "session/\(sessionId)/url"
    }

    var method: HTTPMethod = .POST

    var headers: HTTPHeaders = [:]

    var body: HTTPClient.Body? {
        let requestBody = PostNavigationRequest
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

extension PostNavigationRequest {
    struct RequestBody: Codable {
        let url: String
    }
}
