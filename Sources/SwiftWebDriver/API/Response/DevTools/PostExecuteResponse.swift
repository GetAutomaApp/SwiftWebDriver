import AnyCodable
import Foundation

public struct PostExecuteResponse: ResponseType {
    let value: AnyCodableValue?
}
