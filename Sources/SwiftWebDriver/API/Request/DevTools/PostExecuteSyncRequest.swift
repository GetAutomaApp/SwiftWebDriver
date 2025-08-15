// PostExecuteSyncRequest.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import AsyncHTTPClient
import Foundation
import NIO
import NIOHTTP1

internal struct PostExecuteSyncRequest: RequestType {
    public typealias Response = PostExecuteResponse

    public var baseURL: URL

    public var sessionId: String

    public var path: String {
        "session/\(sessionId)/execute/sync"
    }

    public let javascriptSnippet: RequestBody

    public var method: HTTPMethod = .POST

    public var headers: HTTPHeaders = [:]

    public var body: HTTPClient.Body? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        guard let data = try? encoder.encode(javascriptSnippet) else {
            return nil
        }

        return .data(data)
    }
}

internal extension PostExecuteSyncRequest {
    struct RequestBody: Encodable {
        let script: String
        let args: [AnyEncodable]
    }
}
