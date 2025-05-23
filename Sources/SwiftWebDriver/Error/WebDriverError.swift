// WebDriverError.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

import Foundation

internal enum WebDriverError: LocalizedError {
    case sessionIdIsNil
    public var errorDescription: String? {
        switch self {
        case .sessionIdIsNil:
            "session id must not be nil"
        }
    }
}
