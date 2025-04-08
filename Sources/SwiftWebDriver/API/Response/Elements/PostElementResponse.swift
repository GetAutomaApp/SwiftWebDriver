// PostElementResponse.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

import Foundation

public struct PostElementResponse: ResponseType {
    public let elementId: String

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RoodCodingKey.self)
        let valueContainer = try container.nestedContainer(keyedBy: RoodCodingKey.self, forKey: .value)

        guard let elementKey = valueContainer.allKeys.first else {
            throw APIError.decodingKeyNotFound
        }

        elementId = try valueContainer.decode(String.self, forKey: elementKey)
    }

    public struct RoodCodingKey: CodingKey {
        public var stringValue: String
        public var intValue: Int?

        public init(stringValue: String) {
            self.stringValue = stringValue
        }

        public init(intValue: Int) {
            stringValue = "\(intValue)"
            self.intValue = intValue
        }

        public static let value = Self(stringValue: "value")
    }
}
