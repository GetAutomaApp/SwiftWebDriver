// PostNavigationForwardRequest.swift
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

internal struct PostNavigationForwardRequest: RequestType {
    public typealias Response = PostNavigationForwardResponse

    public var baseURL: URL

    public var sessionId: String

    public var path: String {
        "session/\(sessionId)/forward"
    }

    public var method: HTTPMethod = .POST

    public var headers: HTTPHeaders = [:]

    public var body: HTTPClient.Body? {
        let requestBody = Self
            .RequestBody(additionalProp1: nil, additionalProp2: nil, additionalProp3: nil)

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

internal extension PostNavigationForwardRequest {
    struct RequestBody: Codable {
        public let additionalProp1: AdditionalProp?
        public let additionalProp2: AdditionalProp?
        public let additionalProp3: AdditionalProp?
    }
}

// MARK: - PostNavigationRequest.RequestBody.AdditionalProp

internal extension PostNavigationForwardRequest.RequestBody {
    struct AdditionalProp: Codable {}
}
