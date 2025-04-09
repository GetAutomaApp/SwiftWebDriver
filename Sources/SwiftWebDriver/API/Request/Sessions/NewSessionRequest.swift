// NewSessionRequest.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

import AsyncHTTPClient
import Foundation
import NIOHTTP1

internal struct NewSessionRequest: RequestType {
    public typealias Response = NewSessionResponse

    public var baseURL: URL

    public var path: String = "session"

    public var method: HTTPMethod = .POST

    public var headers: HTTPHeaders = .init(
        [
            ("Content-Type", "application/json"),
        ]
    )

    public let chromeOptions: ChromeOptions

    public var body: HTTPClient.Body? {
        let requestBody = Self
            .RequestBody(
                capabilities: RequestBody.Capabilities(
                    alwaysMatch: RequestBody.Capabilities.AlwaysMatch(
                        chromeOptions: chromeOptions
                    )
                )
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

// MARK: - NewSessionRequest.RequestBody

internal extension NewSessionRequest {
    struct RequestBody: Codable {
        public let capabilities: Capabilities
    }
}

// MARK: - NewSessionRequest.RequestBody.Capabilities

internal extension NewSessionRequest.RequestBody {
    struct Capabilities: Codable {
        public let alwaysMatch: AlwaysMatch
        public enum CodingKeys: String, CodingKey {
            case alwaysMatch
        }
    }
}

// MARK: - NewSessionRequest.RequestBody.Capabilities.AlwaysMatch

internal extension NewSessionRequest.RequestBody.Capabilities {
    struct AlwaysMatch: Codable {
        public let chromeOptions: ChromeOptions

        public enum CodingKeys: String, CodingKey {
            case chromeOptions = "goog:chromeOptions"
        }
    }
}
