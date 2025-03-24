// GetSessionActiveElementRequest.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

import Foundation

import AsyncHTTPClient
import Foundation
import NIO
import NIOHTTP1

struct GetSessionActiveElementRequest: RequestType {
    typealias Response = GetSessionActiveElementResponse

    var baseURL: URL

    var sessionId: String

    var path: String {
        "session/\(sessionId)/element/active"
    }

    var method: HTTPMethod = .GET

    var headers: HTTPHeaders = [:]

    var body: HTTPClient.Body?
}
