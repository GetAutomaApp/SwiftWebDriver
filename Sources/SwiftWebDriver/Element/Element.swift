import Foundation
import NIO

public protocol FindElementProtocol {
    func findElement(_ locatorType: LocatorType) async throws -> Element
    func findElements(_ locatorType: LocatorType) async throws -> Elements
    func waitUntil(_ locatorType: LocatorType, retryCount: Int, durationSeconds: Int) async throws -> Bool
}

public protocol ElementCommandProtocol: FindElementProtocol {
    func text() async throws -> String
    func name() async throws -> String
    func click() async throws -> String?
    func clear() async throws -> String?
    func attribute(name: String) async throws -> String
    func send(value: String) async throws -> String?
    func screenshot() async throws -> String
}

public struct Element: ElementCommandProtocol, Sendable {
    let baseURL: URL
    public let sessionId: String
    public let elementId: String

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func findElement(_ locatorType: LocatorType) async throws -> Element {
        let request = PostElementByIdRequest(baseURL: baseURL, sessionId: sessionId, elementId: elementId, cssSelector: locatorType.create())
        let response = try await APIClient.shared.request(request)
        return Element(baseURL: baseURL, sessionId: sessionId, elementId: response.elementId)
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func findElements(_ locatorType: LocatorType) async throws -> Elements {
        let request = PostElementsByIdRequest(baseURL: baseURL, sessionId: sessionId, elementId: elementId, cssSelector: locatorType.create())
        let response = try await APIClient.shared.request(request)
        return response.value.map { elementId in
            Element(baseURL: baseURL, sessionId: sessionId, elementId: elementId)
        }
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func text() async throws -> String {
        let request = GetElementTextRequest(baseURL: baseURL, sessionId: sessionId, elementId: elementId)
        let response = try await APIClient.shared.request(request)
        return response.value
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func name() async throws -> String {
        let request = GetElementNameRequest(baseURL: baseURL, sessionId: sessionId, elementId: elementId)
        let response = try await APIClient.shared.request(request)
        return response.value
    }

    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func click() async throws -> String? {
        let request = PostElementClickRequest(baseURL: baseURL, sessionId: sessionId, elementId: elementId)
        let response = try await APIClient.shared.request(request)
        return response.value
    }

    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func clear() async throws -> String? {
        let request = PostElementClearRequest(baseURL: baseURL, sessionId: sessionId, elementId: elementId)
        let response = try await APIClient.shared.request(request)
        return response.value
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func attribute(name: String) async throws -> String {
        let request = GetElementAttributeRequest(baseURL: baseURL, sessionId: sessionId, elementId: elementId, name: name)
        let response = try await APIClient.shared.request(request)
        return response.value
    }

    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func send(value: String) async throws -> String? {
        let request = PostElementSendValueRequest(baseURL: baseURL, sessionId: sessionId, elementId: elementId, text: value)
        let response = try await APIClient.shared.request(request)
        return response.value
    }

    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func send(value: SpecialKey) async throws -> String? {
        let request = PostElementSendValueRequest(
            baseURL: baseURL,
            sessionId: sessionId,
            elementId: elementId,
            text: value.unicode
        )
        let response = try await APIClient.shared.request(request)
        return response.value
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func screenshot() async throws -> String {
        let request = GetElementScreenShotRequest(baseURL: baseURL, sessionId: sessionId, elementId: elementId)
        let response = try await APIClient.shared.request(request)
        return response.value
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    @discardableResult
    public func waitUntil(_ locatorType: LocatorType, retryCount: Int = 3, durationSeconds: Int = 1) async throws -> Bool {
        do {
            try await findElement(locatorType)
            return true
        } catch {
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
