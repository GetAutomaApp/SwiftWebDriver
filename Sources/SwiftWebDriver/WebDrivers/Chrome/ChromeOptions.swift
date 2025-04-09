// ChromeOptions.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

import Foundation
import NIOCore

public protocol StatableObject: Codable {}

public typealias Args = String

public struct ChromeOptions: StatableObject {
    public let args: [Args]?

    public init(args: [Args]?) {
        self.args = args
    }
}

public extension Args {
    init(_ args: Arguments) {
        self.init(describing: args)
    }

    enum Arguments: CustomStringConvertible, Codable {
        case headless
        case noSandbox
        case disableGPU
        case windowSize(width: CGFloat, height: CGFloat)
        case startMaximized
        case disableDevShmUsage
        case useFakeUIForMediaStream
        case useFakeDeviceForMedia
        case useFileForFakeVideoCapture
        case useFileForFakeAudioCapture
        case disableExtensions
        case proxyServer(proxyURL: String)
        case userDataDir(dir: String)

        public var description: String {
            switch self {
            case .headless:
                "--headless"
            case .noSandbox:
                "--no-sandbox"
            case .disableGPU:
                "--disable-gpu"
            case let .windowSize(width, height):
                "--window-size=\(width),\(height)"
            case .startMaximized:
                "--start-maximized"
            case .disableDevShmUsage:
                "--disable-dev-shm-usage"
            case .useFakeUIForMediaStream:
                "--use-fake-ui-for-media-stream"
            case .useFakeDeviceForMedia:
                "--use-fake-device-for-media-stream"
            case .useFileForFakeVideoCapture:
                "--use-file-for-fake-video-capture"
            case .useFileForFakeAudioCapture:
                "--use-file-for-fake-audio-capture"
            case .disableExtensions:
                "--disable-extensions"
            case let .proxyServer(proxyURL):
                "--proxy-server=\(proxyURL)"
            case let .userDataDir(dir):
                "--user-data-dir=\(dir)"
            }
        }
    }
}
