// DeleteSessionRequest.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import AsyncHTTPClient
import Foundation
import NIOHTTP1

internal struct DeleteSessionRequest: RequestType {
    public typealias Response = DeleteSessionResponse

    public var baseURL: URL

    public var sessionId: String

    public var path: String {
        "session/\(sessionId)"
    }

    public var method: HTTPMethod = .DELETE

    public var headers: HTTPHeaders = [:]

    public var body: HTTPClient.Body?
}
