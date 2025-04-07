// PostElementClickRequest.swift
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

internal struct PostElementClickRequest: RequestType {
    public typealias Response = PostElementClickResponse

    public var baseURL: URL

    public var sessionId: String

    public var elementId: String

    public var path: String {
        "session/\(sessionId)/element/\(elementId)/click"
    }

    public var method: HTTPMethod = .POST

    public var headers: HTTPHeaders = [:]

    public var body: HTTPClient.Body? {
        let requestBody = PostElementRequest
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

internal extension PostElementRequest {
    struct RequestBody: Codable {
        public let additionalProp1: AdditionalProp?
        public let additionalProp2: AdditionalProp?
        public let additionalProp3: AdditionalProp?
    }
}

internal extension PostElementRequest.RequestBody {
    struct AdditionalProp: Codable {}
}
