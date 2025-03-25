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

struct NewSessionRequest: RequestType {
    typealias Response = NewSessionResponse

    var baseURL: URL

    var path: String = "session"

    var method: HTTPMethod = .POST

    var headers: HTTPHeaders = .init(
        [
            ("Content-Type", "application/json"),
        ]
    )

    let chromeOptions: ChromeOptions

    var body: HTTPClient.Body? {
        let requestBody = NewSessionRequest
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

extension NewSessionRequest {
    struct RequestBody: Codable {
        let capabilities: Capabilities
    }
}

// MARK: - NewSessionRequest.RequestBody.Capabilities

extension NewSessionRequest.RequestBody {
    struct Capabilities: Codable {
        let alwaysMatch: AlwaysMatch
        enum CodingKeys: String, CodingKey {
            case alwaysMatch
        }
    }
}

// MARK: - NewSessionRequest.RequestBody.Capabilities.AlwaysMatch

extension NewSessionRequest.RequestBody.Capabilities {
    struct AlwaysMatch: Codable {
        let chromeOptions: ChromeOptions

        enum CodingKeys: String, CodingKey {
            case chromeOptions = "goog:chromeOptions"
        }
    }
}
