import Foundation

public struct StatusResponse: ResponseType {
    public let value: Value

    public struct Value: ResponseType {
        public let ready: Bool
        public let message: String
    }
}
