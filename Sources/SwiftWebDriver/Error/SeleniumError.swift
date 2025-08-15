// SeleniumError.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Foundation

/// Represents the types of errors defined by the Selenium JSON Wire Protocol.
///
/// See [Selenium JSON Wire Protocol Error
/// Handling](https://www.selenium.dev/documentation/legacy/json_wire_protocol/#error-handling)
/// for reference.
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
    case timeout
    case unableToSetCookie = "unable to set cookie"
    case unexpectedAlertOpen = "unexpected alert open"
    case unknownCommand = "unknown command"
    case unknownError = "unknown error"
    /// Fallback value for unrecognized or unknown errors.
    case unrecognized
    case unsupportedOperation = "unsupported operation"
}

/// Represents a Selenium error returned from the WebDriver server.
public struct SeleniumError: Codable, LocalizedError {
    /// The detailed error information returned by the WebDriver server.
    public let value: Value

    /// A localized description of the error combining the error type and message.
    public var errorDescription: String? {
        "error : \(errorType), message: \(value.message)"
    }

    /// The `SeleniumErrorType` corresponding to the error.
    ///
    /// Returns `.unrecognized` if the error string does not match any known Selenium error.
    public var errorType: SeleniumErrorType {
        SeleniumErrorType(rawValue: value.error) ?? .unrecognized
    }

    /// Encapsulates the raw error data returned by the WebDriver server.
    public struct Value: Codable, Sendable {
        /// The human-readable error message.
        public let message: String

        /// The raw error string returned by Selenium.
        public let error: String
    }
}

public extension Error {
    /// Checks whether the error is a `SeleniumError` of a specific type.
    ///
    /// - Parameter type: The Selenium error type to check for.
    /// - Returns: `true` if the error is a `SeleniumError` matching the specified type, otherwise `false`.
    func isSeleniumError(ofType type: SeleniumErrorType) -> Bool {
        guard let seleniumError = self as? SeleniumError else { return false }
        return seleniumError.errorType == type
    }

    /// Casts the error to a `SeleniumError` of a specific type.
    ///
    /// - Parameter type: The Selenium error type to match.
    /// - Returns: A `SeleniumError` if the error matches the type, otherwise `nil`.
    func asSeleniumError(ofType type: SeleniumErrorType) -> SeleniumError? {
        guard let seleniumError = self as? SeleniumError,
              seleniumError.errorType == type else { return nil }
        return seleniumError
    }
}
