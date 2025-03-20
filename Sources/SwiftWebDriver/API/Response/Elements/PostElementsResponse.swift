import Foundation

public struct PostElementsResponse: Codable {

    var value : [String]

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CustomCodingKey.self)
        let key = container.allKeys.first!
        var valueContainer = try container.nestedUnkeyedContainer(forKey: key)

        var _elementIds: [String] = []

        while !valueContainer.isAtEnd {
            let elementContainer = try valueContainer.nestedContainer(keyedBy: CustomCodingKey.self)
            guard let key = elementContainer.allKeys.first else { continue }
            let elementId = try elementContainer.decode(String.self, forKey: key)
            _elementIds.append(elementId)
        }

        self.value = _elementIds
    }

    struct CustomCodingKey: CodingKey {
        var stringValue: String
        var intValue: Int?

        init?(stringValue: String) {
            self.stringValue = stringValue
        }

        init?(intValue: Int) {
            self.stringValue = "\(intValue)"
            self.intValue = intValue
        }

        static let value = CustomCodingKey(stringValue: "value")!
    }

    enum CustomValueKey: String, CodingKey {
        case wildcard
    }
}
