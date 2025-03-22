import Foundation

enum WebDriverError: LocalizedError {
    case sessionIdIsNil
    var errorDescription: String? {
        switch self {
        case .sessionIdIsNil:
            return "session id must not be nil"
        }
    }
}
