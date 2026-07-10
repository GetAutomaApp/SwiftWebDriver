// WebDriverError.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

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
