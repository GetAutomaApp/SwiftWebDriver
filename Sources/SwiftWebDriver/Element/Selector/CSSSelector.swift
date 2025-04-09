// CSSSelector.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

import Foundation

public enum CSSSelector: Sendable {
    case `class`(_ value: String)
    case id(_ value: String)
    case name(_ value: String)

    internal func create() -> LocatorSelector {
        switch self {
        case let .id(value):
            LocatorSelector(using: "css selector", value: "#\(value)")
        case let .class(value):
            LocatorSelector(using: "css selector", value: ".\(value)")
        case let .name(value):
            LocatorSelector(using: "css selector", value: "[name=\(value)]")
        }
    }
}
