// StatusResponse.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

import Foundation

public struct StatusResponse: ResponseType {
    public let value: Value

    public struct Value: ResponseType {
        public let ready: Bool
        public let message: String
    }
}
