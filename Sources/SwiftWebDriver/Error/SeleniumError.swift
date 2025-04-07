// SeleniumError.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

import Foundation

public struct SeleniumError: Codable, LocalizedError {
    public let value: Value
    public var errorDescription: String? {
        "error : \(value.error), message: \(value.message)"
    }
}

public extension SeleniumError {
    struct Value: Codable, Sendable {
        public let message: String
        public let error: String
    }
}
