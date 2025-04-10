// SeleniumError.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

import Foundation

/// https://www.selenium.dev/documentation/legacy/json_wire_protocol/#error-handling
public enum SeleniumErrorType: String, Codable {
    case elementClickIntercepted = "element click intercepted"
    case elementNotInteractable = "element not interactable"
    case elementNotSelectable = "element not selectable"
    case elementNotVisible = "element not visible"
    case invalidArgument = "invalid argument"
    case invalidCookieDomain = "invalid cookie domain"
    case invalidElementState = "invalid element state"
    case invalidSelector = "invalid selector"
    case javascriptError = "javascript error"
    case moveTargetOutOfBounds = "move target out of bounds"
    case noSuchAlert = "no such alert"
    case noSuchElement = "no such element"
    case noSuchFrame = "no such frame"
    case noSuchWindow = "no such window"
    case scriptTimeout = "script timeout"
    case sessionNotCreated = "session not created"
    case staleElementReference = "stale element reference"
    case timeout = "timeout"
    case unableToSetCookie = "unable to set cookie"
    case unexpectedAlertOpen = "unexpected alert open"
    case unknownCommand = "unknown command"
    case unknownError = "unknown error"
    case unsupportedOperation = "unsupported operation"

    /// Fallback for unknown errors
    case unrecognized
}

public struct SeleniumError: Codable, LocalizedError {
    public let value: Value

    public var errorDescription: String? {
        "error : \(errorType), message: \(value.message)"
    }

    public var errorType: SeleniumErrorType {
        SeleniumErrorType(rawValue: value.error) ?? .unrecognized
    }

    public struct Value: Codable, Sendable {
        public let message: String
        public let error: String
    }
}

public extension Error {
    public func isSeleniumError(ofType type: SeleniumErrorType) -> Bool {
        guard let seleniumError = self as? SeleniumError else { return false }
        return seleniumError.errorType == type
    }

    public func asSeleniumError(ofType type: SeleniumErrorType) -> SeleniumError? {
        guard let seleniumError = self as? SeleniumError,
              seleniumError.errorType == type else { return nil }
        return seleniumError
    }
}
