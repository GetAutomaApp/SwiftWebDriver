//
//  Broser.swift
//  
//
//  Created by ashizawa on 2022/06/01.
//

import Foundation
import NIOCore

public typealias Args = String

public struct ChromeOptions: StatableOpject {
    public let args: [Args]?
    
    public init (args: [Args]?) {
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
                return "--headless"
            case .noSandbox:
                return "--no-sandbox"
            case .disableGPU:
                return "--disable-gpu"
            case .windowSize(let width, let height):
                return "--window-size=\(width),\(height)"
            case .startMaximized:
                return "--start-maximized"
            case .disableDevShmUsage:
                return "--disable-dev-shm-usage"
            case .useFakeUIForMediaStream:
                return "--use-fake-ui-for-media-stream"
            case .useFakeDeviceForMedia:
                return "--use-fake-device-for-media-stream"
            case .useFileForFakeVideoCapture:
                return "--use-file-for-fake-video-capture"
            case .useFileForFakeAudioCapture:
                return "--use-file-for-fake-audio-capture"
            case .disableExtensions:
                return "--disable-extensions"
            case .proxyServer(let proxyURL):
                return "--proxy-server=\(proxyURL)"
            case .userDataDir(let dir):
                return "--user-data-dir=\(dir)"
            }
        }
    }
}
