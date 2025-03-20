import Foundation

public struct PostElementResponse: Codable {

    let elementId : String

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RoodCodingKey.self)
        let valueContainer = try container.nestedContainer(keyedBy: RoodCodingKey.self, forKey: .value)

        guard let elementKey = valueContainer.allKeys.first else {
            throw APIError.decodingKeyNotFound
        }

        self.elementId = try valueContainer.decode(String.self, forKey: elementKey)
    }

    struct RoodCodingKey: CodingKey {
        var stringValue: String
        var intValue: Int?

        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        init?(intValue: Int) {
            self.stringValue = "\(intValue)"
            self.intValue = intValue
        }

        static let value = RoodCodingKey(stringValue: "value")!
    }
}
