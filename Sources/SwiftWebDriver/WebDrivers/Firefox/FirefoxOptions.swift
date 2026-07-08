// FirefoxOptions.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

// ChromeOptions.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// import Foundation
// import NIOCore

public struct FirefoxOptions: Codable {
    public let binary: String?
    public let args: [FirefoxArgs]?
    public let profile: String?
    public let prefs: [String: FirefoxPreferenceValue]?
    public let log: FirefoxLog?
    public let env: [String: String]?

    init(
        binary: String? = nil,
        args: [FirefoxArgs]? = nil,
        profile: String? = nil,
        prefs: [String: FirefoxPreferenceValue]? = nil,
        log: FirefoxLog? = nil,
        env: [String: String]? = nil
    ) {
        self.binary = binary
        self.args = args
        self.profile = profile
        self.prefs = prefs
        self.log = log
        self.env = env
    }
}

public struct FirefoxArgs: RawRepresentable, Codable, CustomStringConvertible {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

    public init(_ argument: Argument) {
        rawValue = argument.description
    }

    public var description: String {
        rawValue
    }

    public enum Argument: CustomStringConvertible, Codable {
        case headless
        case privateMode
        case privateWindow
        case devTools
        case safeMode

        public var description: String {
            switch self {
            case .headless:
                "-headless"
            case .privateMode:
                "-private"
            case .privateWindow:
                "-private-window"
            case .devTools:
                "-devtools"
            case .safeMode:
                "-safe-mode"
            }
        }
    }
}

public enum FirefoxPreferenceValue: Codable {
    case string(String)
    case bool(Bool)
    case int(Int)
}

public struct FirefoxLog: Codable {
    public let level: Level

    public init(level: Level) {
        self.level = level
    }

    public enum Level: String, Codable {
        case trace
        case debug
        case config
        case info
        case warn
        case error
        case fatal
    }
}
