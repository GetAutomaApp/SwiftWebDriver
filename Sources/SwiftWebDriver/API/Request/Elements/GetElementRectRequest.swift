// GetElementRectRequest.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import AsyncHTTPClient
import Foundation
import NIO
import NIOHTTP1

internal struct GetElementRectRequest: RequestType {
    typealias Response = GetElementRectResponse

    var baseURL: URL
    var sessionId: String
    var elementId: String

    var path: String { "session/\(sessionId)/element/\(elementId)/rect" }
    var method: HTTPMethod = .GET
    var headers: HTTPHeaders = [:]
    var body: HTTPClient.Body? { nil }
}
