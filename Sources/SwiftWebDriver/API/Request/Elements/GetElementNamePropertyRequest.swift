// GetElementNamePropertyRequest.swift
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

struct GetElementNamePropertyRequest: RequestType {
    typealias Response = GetElementNamePropertyResponse

    var baseURL: URL

    var sessionId: String

    var elementId: String

    var name: String

    var path: String {
        "session/\(sessionId)/element/\(elementId)/prorety/\(name)"
    }

    var method: HTTPMethod = .GET

    var headers: HTTPHeaders = [:]

    var body: HTTPClient.Body?
}
