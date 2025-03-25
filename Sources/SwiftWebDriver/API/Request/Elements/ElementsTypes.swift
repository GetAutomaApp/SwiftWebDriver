// ElementsTypes.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

public enum SendValueActionKeyTypes: String {
    case RETURN1 = "\u{E006}"
    case ENTER1 = "\u{E007}"
    case TAB = "\u{E004}"

    var unicode: String {
        rawValue
    }
}
