// GetSessionActiveElementResponse.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Foundation

internal struct GetSessionActiveElementResponse: ResponseType {
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
            stringValue = String(intValue)
            self.intValue = intValue
        }

        public static let value = Self(stringValue: "value")
    }
}
