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
//

public struct FirefoxOptions: Codable {
    public let binary: String?
    public let args: [FirefoxArgument]?
    public let profile: String?
    public let prefs: [String: FirefoxPreferenceValue]?
    public let log: FirefoxLog?
    public let env: [String: String]?

    init(
        binary: String? = nil,
        args: [FirefoxArgument]? = nil,
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

public enum FirefoxArgument: CustomStringConvertible, Codable {
    case headless
    case profile(path: String)
    case privateMode
    case privateWindow
    case newWindow(url: String)
    case newTab(url: String)
    case kiosk(url: String)
    case devTools
    case safeMode

    public var description: String {
        switch self {
        case .headless:
            "-headless"
        case let .profile(path):
            "-profile \(path)"
        case .privateMode:
            "-private"
        case .privateWindow:
            "-private-window"
        case let .newWindow(url):
            "-new-window \(url)"
        case let .newTab(url):
            "-new-tab \(url)"
        case let .kiosk(url):
            "--kiosk \(url)"
        case .devTools:
            "-devtools"
        case .safeMode:
            "-safe-mode"
        }
    }
}

public typealias FirefoxArg = String

public extension FirefoxArg {
    init(_ argument: FirefoxArgument) {
        self.init(describing: argument)
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
