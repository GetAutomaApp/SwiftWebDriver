// ChromeOptions.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Foundation
import NIOCore

/// Typealias for a single ChromeOptions argument
public typealias Args = String

/// ChromeOptions data structure, used to configure Chrome Driver instantiation
public struct ChromeOptions: Codable {
    /// Chrome arguments
    public let args: [Args]?

    /// Initialize ChromeOptions
    /// - Parameter args: an array of arguments
    public init(args: [Args]?) {
        self.args = args
    }
}

/// Restrict arguments to an enum of allowed arguments
public extension Args {
    /// Initialize chrome option argument
    init(_ args: Arguments) {
        self.init(describing: args)
    }

    /// All allowed arguments, with their flag value coupled (research Chrome Driver argument definitions to know what
    /// each argument means)
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

        /// Case descriptions
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
