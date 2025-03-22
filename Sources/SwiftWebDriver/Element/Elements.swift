import Foundation

public typealias Elements = Array<Element>

extension Elements {

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func texts() async throws -> [String] {

        var ids: [String] = []
        try await withThrowingTaskGroup(of: GetElementTextResponse.self) { group in
            for element in self {
                let request = GetElementTextRequest(
                    baseURL: element.baseURL,
                    sessionId: element.sessionId,
                    elementId: element.elementId)

                group.addTask {
                    return try await APIClient.shared.request(request)
                }
            }
            for try await element in group {
                ids.append(element.value)
            }
        }

        return ids
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func names() async throws -> [String] {

        var names: [String] = []
        try await withThrowingTaskGroup(of: GetElementNameResponse.self) { group in
            for element in self {
                let request = GetElementNameRequest(
                    baseURL: element.baseURL,
                    sessionId: element.sessionId,
                    elementId: element.elementId)

                group.addTask {
                    return try await APIClient.shared.request(request)
                }
            }
            for try await element in group {
                names.append(element.value)
            }
        }

        return names
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func findElement(_ locatorType: LocatorType) async throws -> Elements {
        var elements: Elements = []
        try await withThrowingTaskGroup(of: Element.self) { group in

            for element in self {
                group.addTask {
                    return try await element.findElement(locatorType)
                }
            }

            for try await element in group {
                elements.append(element)
            }
        }

        return elements
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func findElements(_ locatorType: LocatorType) async throws -> Elements {
        var elements: Array<Elements> = Array<Elements>()
        try await withThrowingTaskGroup(of: Elements.self) { group in
            for element in self {
                group.addTask {
                    return try await element.findElements(locatorType)
                }
            }
            for try await responseElements in group {
                elements.append(responseElements)
            }
        }

        return elements.flatMap{ $0 }
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    @discardableResult
    public func waitUntil(_ locatorType: LocatorType, retryCount: Int = 3, durationSeconds: Int = 1) async throws -> Bool {

        do {
            let _ = try await findElement(locatorType)
            return true
        } catch let error {
            guard
                retryCount > 0,
                let error = error as? SeleniumError
                else { return false }

            guard error.value.error == "no such element" else {
                return false
            }

            let retryCount = retryCount - 1

            sleep(UInt32(durationSeconds))

            return try await waitUntil(locatorType, retryCount: retryCount, durationSeconds: durationSeconds)
        }
    }
}
