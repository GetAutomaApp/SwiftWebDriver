// PostElementClearRequest.swift
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

struct PostElementClearRequest: RequestType {
    typealias Response = PostElementClearResponse

    var baseURL: URL

    var sessionId: String

    var elementId: String

    var path: String {
        "session/\(sessionId)/element/\(elementId)/clear"
    }

    var method: HTTPMethod = .POST

    var headers: HTTPHeaders = [:]

    var body: HTTPClient.Body? {
        let requestBody = PostElementClearRequest
            .RequestBody(
                additionalProp1: nil,
                additionalProp2: nil,
                additionalProp3: nil
            )

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(requestBody)

        guard let data else {
            return nil
        }

        return .data(data)
    }
}

extension PostElementClearRequest {
    struct RequestBody: Codable {
        let additionalProp1: AdditionalProp?
        let additionalProp2: AdditionalProp?
        let additionalProp3: AdditionalProp?
    }
}

extension PostElementClearRequest.RequestBody {
    struct AdditionalProp: Codable {}
}
