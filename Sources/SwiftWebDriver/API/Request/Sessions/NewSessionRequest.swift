// NewSessionRequest.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import AsyncHTTPClient
import Foundation
import NIOHTTP1

internal struct NewSessionRequest<Options: BrowserOptions>: RequestType {
    public typealias Response = NewSessionResponse

    public var baseURL: URL
    public var path: String = "session"
    public var method: HTTPMethod = .POST
    public var headers: HTTPHeaders = .init([
        ("Content-Type", "application/json")
    ])

    public let browserOptions: Options

    public var body: HTTPClient.Body? {
        let requestBody = RequestBody(
            capabilities: RequestBodyCapabilities(
                alwaysMatch: AlwaysMatch(
                    browserOptions: browserOptions
                )
            )
        )

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        guard let data = try? encoder.encode(requestBody) else {
            return nil
        }

        return .data(data)
    }
}

internal extension NewSessionRequest {
    struct RequestBody: Codable {
        internal let capabilities: RequestBodyCapabilities
    }

    struct Capabilities: Codable {
        internal let alwaysMatch: AlwaysMatch
    }

    struct AlwaysMatch: Encodable, Decodable {
        internal let browserOptions: Options

        internal enum StaticCodingKeys: String, CodingKey {
            case browserName
        }

        internal struct DynamicCodingKey: CodingKey {
            internal let stringValue: String

            internal let intValue: Int? = nil

            internal init(stringValue: String) {
                self.stringValue = stringValue
            }

            internal init?(intValue _: Int) {
                nil
            }
        }

        internal func encode(to encoder: Encoder) throws {
            var staticContainer = encoder.container(keyedBy: StaticCodingKeys.self)

            try staticContainer.encode(Options.browserName, forKey: .browserName)

            var dynamicContainer = encoder.container(keyedBy: DynamicCodingKey.self)

            try dynamicContainer.encode(
                browserOptions,

                forKey: DynamicCodingKey(stringValue: Options.codingKey)
            )
        }
    }
}

// MARK: - NewSessionRequest.RequestBody

// internal extension NewSessionRequest {
//     struct RequestBody: Codable {
//         public let capabilities: Capabilities
//     }
// }

// MARK: - NewSessionRequest.RequestBody.Capabilities

internal extension NewSessionRequest {
    struct RequestBodyCapabilities: Encodable, Decodable {
        internal let alwaysMatch: AlwaysMatch
    }
}

// MARK: - NewSessionRequest.RequestBody.Capabilities.AlwaysMatch

// internal extension NewSessionRequest.RequestBody.Capabilities {
//     struct AlwaysMatch: Codable {
//         public let chromeOptions: ChromeOptions
//
//         public enum CodingKeys: String, CodingKey {
//             case chromeOptions = "goog:chromeOptions"
//             case firefoxOptions = "moz:firefoxOptions"
//         }
//     }
// }

internal protocol BrowserOptions: Codable, Decodable {
    static var browserName: String { get }
    static var codingKey: String { get }
}

extension ChromeOptions: BrowserOptions {
    internal static let browserName = "chrome"
    internal static let codingKey = "goog:chromeOptions"
}

extension FirefoxOptions: BrowserOptions {
    internal static let browserName = "firefox"
    internal static let codingKey = "moz:firefoxOptions"
}
