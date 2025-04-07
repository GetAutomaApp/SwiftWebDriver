// StatusRequest.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

import AsyncHTTPClient
import Foundation
import NIOHTTP1

internal struct StatusRequest: RequestType {
    public typealias Response = StatusResponse

    public var baseURL: URL

    public var path: String = "status"

    public var method: HTTPMethod = .GET

    public var headers: HTTPHeaders = [:]

    public var body: HTTPClient.Body?
}
