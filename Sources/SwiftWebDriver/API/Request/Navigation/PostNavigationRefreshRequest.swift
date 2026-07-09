// PostNavigationRefreshRequest.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import AsyncHTTPClient
import Foundation
import NIO
import NIOHTTP1

internal struct PostNavigationRefreshRequest: RequestType {
    public typealias Response = PostNavigationRefreshResponse

    public var baseURL: URL

    public var sessionId: String

    public var path: String {
        "session/\(sessionId)/refresh"
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

internal extension PostNavigationRefreshRequest {
    struct RequestBody: Codable {
        public let additionalProp1: AdditionalProp?
        public let additionalProp2: AdditionalProp?
        public let additionalProp3: AdditionalProp?
    }
}

// MARK: - PostNavigationRequest.RequestBody.AdditionalProp

internal extension PostNavigationRefreshRequest.RequestBody {
    struct AdditionalProp: Codable {}
}
