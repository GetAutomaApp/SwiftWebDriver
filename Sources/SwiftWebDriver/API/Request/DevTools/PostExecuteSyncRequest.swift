// PostExecuteSyncRequest.swift
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

struct PostExecuteSyncRequest: RequestType {
    typealias Response = PostExecuteResponse

    var baseURL: URL

    var sessionId: String

    var path: String {
        "session/\(sessionId)/execute/sync"
    }

    let javascriptSnippet: RequestBody

    var method: HTTPMethod = .POST

    var headers: HTTPHeaders = [:]

    var body: HTTPClient.Body? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        guard let data = try? encoder.encode(javascriptSnippet) else {
            return nil
        }

        return .data(data)
    }
}

extension PostExecuteSyncRequest {
    struct RequestBody: Codable {
        let script: String
        let args: [String]
    }
}
