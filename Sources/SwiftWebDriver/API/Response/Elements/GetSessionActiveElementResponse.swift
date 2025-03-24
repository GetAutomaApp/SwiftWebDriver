// GetSessionActiveElementResponse.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

import Foundation

public struct GetSessionActiveElementResponse: ResponseType {
    let elementId: String

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RoodCodingKey.self)
        let valueContainer = try container.nestedContainer(keyedBy: RoodCodingKey.self, forKey: .value)

        guard let elementKey = valueContainer.allKeys.first else {
            throw APIError.decodingKeyNotFound
        }

        elementId = try valueContainer.decode(String.self, forKey: elementKey)
    }

    struct RoodCodingKey: CodingKey {
        var stringValue: String
        var intValue: Int?

        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        init?(intValue: Int) {
            stringValue = "\(intValue)"
            self.intValue = intValue
        }

        static let value = RoodCodingKey(stringValue: "value")!
    }
}
