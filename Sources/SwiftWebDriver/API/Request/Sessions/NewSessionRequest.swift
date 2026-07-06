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
                alwaysMatch: RequestBodyCapabilities.AlwaysMatch(
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
        let capabilities: RequestBodyCapabilities
    }

    struct Capabilities: Codable {
        let alwaysMatch: AlwaysMatch
    }

    struct AlwaysMatch: Decodable, Encodable {
        let browserName: String
        let browserOptions: Options

        enum StaticCodingKeys: String, CodingKey {
            case browserName
        }

        struct DynamicCodingKey: CodingKey {
            var stringValue: String
            var intValue: Int? {
                nil
            }

            init(stringValue: String) {
                self.stringValue = stringValue
            }

            init?(intValue _: Int) {
                nil
            }
        }

        func encode(to encoder: Encoder) throws {
            var staticContainer = encoder.container(keyedBy: StaticCodingKeys.self)
            try staticContainer.encode(browserName, forKey: .browserName)

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
        let alwaysMatch: AlwaysMatch

        struct AlwaysMatch: Encodable, Decodable {
            let browserOptions: Options

            enum StaticCodingKeys: String, CodingKey {
                case browserName
            }

            struct DynamicCodingKey: CodingKey {
                let stringValue: String

                let intValue: Int? = nil

                init(stringValue: String) {
                    self.stringValue = stringValue
                }

                init?(intValue _: Int) {
                    nil
                }
            }

            func encode(to encoder: Encoder) throws {
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
    static let browserName = "chrome"
    static let codingKey = "goog:chromeOptions"
}

extension FirefoxOptions: BrowserOptions {
    static let browserName = "firefox"
    static let codingKey = "moz:firefoxOptions"
}
