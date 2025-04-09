// LocatorType.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

import Foundation

public enum LocatorType: Sendable {
    case css(_ cssSelector: CSSSelector)
    case linkText(_ linkText: String)
    case partialLinkText(_ particlalLinText: String)
    case tagName(_ tagName: String)
    case xpath(_ path: String)

    public func create() -> LocatorSelector {
        switch self {
        case let .css(cssSelectorType):
            cssSelectorType.create()
        case let .xpath(value):
            LocatorSelector(using: "xpath", value: value)
        case let .linkText(value):
            LocatorSelector(using: "link text", value: value)
        case let .partialLinkText(value):
            LocatorSelector(using: "partial link text", value: value)
        case let .tagName(value):
            LocatorSelector(using: "tag name", value: value)
        }
    }
}
