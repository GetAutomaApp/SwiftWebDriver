import Foundation

internal struct NewSessionResponse: Codable {

    struct Value: Codable {
        let sessionId: String
        let capabilities: Capabilities

        struct Capabilities: Codable {
//            let browserName: String
//            let browserVersion: String
//            let platformName: String
//            let acceptInsecureCerts: Bool
//            let pageLoadStrategy: String
//            let proxy: Proxy
//            let setWindowRect: Bool
//            let timeouts: TimeOuts
//            let strictFileInteractability: Bool
//            let unhandledPromptBehavior: String = "dismiss"
//            let choromeLoggingPrefs: ChromeLoggingPrefs?
//            let chromeOptions: ChromeOptions?
//
//            enum CodingKeys: String, CodingKey {
//                case browserName
//                case browserVersion
//                case platformName
//                case acceptInsecureCerts
//                case pageLoadStrategy
//                case proxy
//                case setWindowRect
//                case timeouts
//                case strictFileInteractability
//                case unhandledPromptBehavior
//                case choromeLoggingPrefs = "goog:loggingPrefs"
//                case chromeOptions = "goog:chromeOptions"
//            }
//
//
//            struct Proxy: Codable {
//                let proxyType: String
//                let proxyAutoconfigUrl: String
//                let ftpProxy: String
//                let httpProxy: String
//                let noProxy: [String]
//                let sslProxy: String
//                let socksProxy: String
//                let socketVersion: Int
//            }
//
//            struct TimeOuts: Codable {
//                let script: Int
//                let pageLoad: Int
//                let implicit: Int
//            }
//
//            struct ChromeLoggingPrefs: Codable {
//                let browser: String
//                let client: String
//                let driver: String
//                let perfomance: String
//                let profiler: String
//                let server: String
//            }
//
//            struct ChromeOptions: Codable {
//                let args: [String]
//                let binary: String
//                let debuggerAddress: String
//                let detach: Bool
//                let excludeSwitches: [String]
//                let extensions: [String]
//                let localState: LocalState
//                let minidumpPath: String
//                let mobileEmulation: MobileEmulation
//                let perfLoggingPrefs: PerfLoggingPrefs
//                let prefs: [Int] // Bool, Int, String
//                let windowTypes: [String]
//
//                struct LocalState: Codable {
//                    let additionalProp1: Bool
//                    let additionalProp2: Bool
//                    let additionalProp3: Bool
//                }
//
//                struct MobileEmulation: Codable {
//                    let deviceName: String
//                    let deviceMetrics: DeviceMetrics
//                    let userAgent: String
//
//                    struct DeviceMetrics: Codable {
//                        let width: Int
//                        let hegiht: Int
//                        let pixelRatio: Double
//                        let touch: Bool
//                    }
//                }
//
//                struct PerfLoggingPrefs: Codable {
//                    let enableNetwork: Bool
//                    let enablePage: Bool
//                    let traceCategories: String
//                    let bufferUsageReportingInterval: Int
//                }
//            }
        }
    }

    let value: NewSessionResponse.Value
}