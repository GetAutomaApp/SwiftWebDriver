// DevToolTypes.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

/// A namespace containing types related to browser developer tool operations.
///
/// `DevToolTypes` groups together constants and enumerations that define
/// configuration or execution modes for actions performed via browser
/// developer tools.
public enum DevToolTypes {
    /// Represents the available modes for executing JavaScript through
    /// browser developer tools.
    public enum JavascriptExecutionTypes {
        /// Executes JavaScript **asynchronously**.
        ///
        /// The execution returns a result only after an asynchronous operation
        /// completes, allowing for `Promise` handling or delayed callbacks.
        case async

        /// Executes JavaScript **synchronously**.
        ///
        /// The execution blocks until a result is immediately available,
        /// without waiting for asynchronous operations.
        case sync
    }
}
