// PostElementsResponse.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

import Foundation

public struct PostElementsResponse: ResponseType {
    public var value: [String]

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CustomCodingKey.self)

        guard let key = container.allKeys.first else {
            throw Self.Errors.keysAreEmpty
        }

        var valueContainer = try container.nestedUnkeyedContainer(forKey: key)

        var elementIds: [String] = []

        while !valueContainer.isAtEnd {
            let elementContainer = try valueContainer.nestedContainer(keyedBy: CustomCodingKey.self)
            guard let key = elementContainer.allKeys.first else { continue }
            let elementId = try elementContainer.decode(String.self, forKey: key)
            elementIds.append(elementId)
        }

        value = elementIds
    }

    public struct CustomCodingKey: CodingKey {
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

    public enum CustomValueKey: String, CodingKey {
        case wildcard
    }

    public enum Errors: Error {
        case keysAreEmpty
    }
}
