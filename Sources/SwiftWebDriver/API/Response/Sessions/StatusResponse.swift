import Foundation

public struct StatusResponse: Codable {
    public let value: Value

    public struct Value: Codable {
        public let ready: Bool
        public let message: String
    }
}
