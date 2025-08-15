// Element.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Foundation
import NIO

internal protocol FindElementProtocol {
    func findElement(_ locatorType: LocatorType) async throws -> Element
    func findElements(_ locatorType: LocatorType) async throws -> Elements
    func waitUntil(_ locatorType: LocatorType, retryCount: Int, durationSeconds: Int) async throws -> Bool
}

internal protocol ElementCommandProtocol: FindElementProtocol {
    func text() async throws -> String
    func name() async throws -> String
    func click() async throws -> String?
    func doubleClick() async throws -> String?
    func dragAndDrop(to target: Element) async throws -> String?
    func clear() async throws -> String?
    func attribute(name: String) async throws -> String
    func send(value: String) async throws -> String?
    func screenshot() async throws -> String
    func rect() async throws -> ElementRect
}

/// Represents a DOM element within a WebDriver session.
///
/// The `Element` struct provides methods to locate child elements, interact with the element,
/// and retrieve its attributes or properties using the Selenium WebDriver protocol.
///
/// Instances of `Element` are created by locating elements through a driver or another element.
/// Each `Element` instance is tied to a specific WebDriver session and element ID.
///
/// - Note: All methods are asynchronous and throw on failure.
/// - Warning: The underlying WebDriver session must remain valid for the lifetime of this element.
public struct Element: ElementCommandProtocol, Sendable {
    /// The base URL of the WebDriver instance.
    public let baseURL: URL

    /// The session identifier of the active WebDriver session.
    public let sessionId: String

    /// The unique element identifier assigned by WebDriver.
    public let elementId: String

    /// Finds the first child element matching the given locator.
    ///
    /// - Parameter locatorType: The locator strategy and value (e.g., CSS selector, XPath).
    /// - Returns: A new `Element` representing the located child element.
    /// - Throws: An error if no matching element is found or if the request fails.
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func findElement(_ locatorType: LocatorType) async throws -> Self {
        let request = PostElementByIdRequest(
            baseURL: baseURL,
            sessionId: sessionId,
            elementId: elementId,
            cssSelector: locatorType.create()
        )
        let response = try await APIClient.shared.request(request)
        return Self(baseURL: baseURL, sessionId: sessionId, elementId: response.elementId)
    }

    /// Finds all child elements matching the given locator.
    ///
    /// - Parameter locatorType: The locator strategy and value.
    /// - Returns: An array of `Element` instances for all matched elements.
    /// - Throws: An error if the request fails.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func findElements(_ locatorType: LocatorType) async throws -> Elements {
        let request = PostElementsByIdRequest(
            baseURL: baseURL,
            sessionId: sessionId,
            elementId: elementId,
            cssSelector: locatorType.create()
        )
        let response = try await APIClient.shared.request(request)
        return response.value.map { elementId in
            Self(baseURL: baseURL, sessionId: sessionId, elementId: elementId)
        }
    }

    /// Retrieves the visible text content of the element.
    ///
    /// - Returns: The text contained within the element.
    /// - Throws: An error if retrieval fails.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func text() async throws -> String {
        let request = GetElementTextRequest(baseURL: baseURL, sessionId: sessionId, elementId: elementId)
        let response = try await APIClient.shared.request(request)
        return response.value
    }

    /// Retrieves the element's tag name (e.g., `"div"`, `"input"`).
    ///
    /// - Returns: The tag name of the element.
    /// - Throws: An error if retrieval fails.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func name() async throws -> String {
        let request = GetElementNameRequest(baseURL: baseURL, sessionId: sessionId, elementId: elementId)
        let response = try await APIClient.shared.request(request)
        return response.value
    }

    /// Clicks the element.
    ///
    /// - Returns: A response string if provided by the WebDriver, otherwise `nil`.
    /// - Throws: An error if the click action fails.
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func click() async throws -> String? {
        let request = PostElementClickRequest(baseURL: baseURL, sessionId: sessionId, elementId: elementId)
        let response = try await APIClient.shared.request(request)
        return response.value
    }

    /// Performs a double-click action on the element.
    ///
    /// - Returns: A response string if provided by the WebDriver, otherwise `nil`.
    /// - Throws: An error if the double-click action fails.
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func doubleClick() async throws -> String? {
        let request = PostElementDoubleClickRequest(baseURL: baseURL, sessionId: sessionId, elementId: elementId)
        let response = try await APIClient.shared.request(request)
        return response.value
    }

    /// Drags this element and drops it onto another target element.
    ///
    /// - Parameter target: The element to drop this element onto.
    /// - Returns: A response string if provided by the WebDriver, otherwise `nil`.
    /// - Throws: An error if the drag-and-drop operation fails.
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func dragAndDrop(to target: Element) async throws -> String? {
        let request = try await PostElementDragAndDropRequest(
            baseURL: baseURL,
            sessionId: sessionId,
            elementId: elementId,
            toElementId: target.elementId,
            targetElementRect: target.rect()
        )
        let response = try await APIClient.shared.request(request)
        return response.value
    }

    /// Retrieves the position and size of the element.
    ///
    /// - Returns: An `ElementRect` containing the element's coordinates and dimensions.
    /// - Throws: An error if retrieval fails.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func rect() async throws -> ElementRect {
        let request = GetElementRectRequest(
            baseURL: baseURL,
            sessionId: sessionId,
            elementId: elementId
        )
        let response = try await APIClient.shared.request(request)
        return response.value
    }

    /// Clears the text from an input or textarea element.
    ///
    /// - Returns: A response string if provided by the WebDriver, otherwise `nil`.
    /// - Throws: An error if the clear operation fails.
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func clear() async throws -> String? {
        let request = PostElementClearRequest(baseURL: baseURL, sessionId: sessionId, elementId: elementId)
        let response = try await APIClient.shared.request(request)
        return response.value
    }

    /// Retrieves the value of the specified attribute for the element.
    ///
    /// - Parameter name: The name of the attribute to retrieve.
    /// - Returns: The attribute value as a string.
    /// - Throws: An error if retrieval fails.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func attribute(name: String) async throws -> String {
        let request = GetElementAttributeRequest(
            baseURL: baseURL,
            sessionId: sessionId,
            elementId: elementId,
            name: name
        )
        let response = try await APIClient.shared.request(request)
        return response.value
    }

    /// Sends text input to the element (e.g., typing into a text field).
    ///
    /// - Parameter value: The string to input.
    /// - Returns: A response string if provided by the WebDriver, otherwise `nil`.
    /// - Throws: An error if sending the value fails.
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func send(value: String) async throws -> String? {
        let request = PostElementSendValueRequest(
            baseURL: baseURL,
            sessionId: sessionId,
            elementId: elementId,
            text: value
        )
        let response = try await APIClient.shared.request(request)
        return response.value
    }

    /// Sends a special key or key combination to the element.
    ///
    /// - Parameter value: A predefined key type to send.
    /// - Returns: A response string if provided by the WebDriver, otherwise `nil`.
    /// - Throws: An error if sending the key fails.
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func send(value: ElementsTypes.SendValueActionKeyTypes) async throws -> String? {
        let request = PostElementSendValueRequest(
            baseURL: baseURL,
            sessionId: sessionId,
            elementId: elementId,
            text: value.unicode
        )
        let response = try await APIClient.shared.request(request)
        return response.value
    }

    /// Takes a screenshot of the element.
    ///
    /// - Returns: A Base64-encoded string representing the image.
    /// - Throws: An error if the screenshot operation fails.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func screenshot() async throws -> String {
        let request = GetElementScreenShotRequest(baseURL: baseURL, sessionId: sessionId, elementId: elementId)
        let response = try await APIClient.shared.request(request)
        return response.value
    }

    /// Waits until an element matching the given locator appears within this element's DOM subtree.
    ///
    /// - Parameters:
    ///   - locatorType: The locator strategy and value.
    ///   - retryCount: Number of retry attempts before giving up. Defaults to `3`.
    ///   - durationSeconds: Delay between retries in seconds. Defaults to `1`.
    /// - Returns: `true` if the element is found, otherwise `false`.
    /// - Throws: Any non-"no such element" error from WebDriver.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    @discardableResult
    public func waitUntil(
        _ locatorType: LocatorType,
        retryCount: Int = 3,
        durationSeconds: Int = 1
    ) async throws -> Bool {
        do {
            try await findElement(locatorType)
            return true
        } catch {
            guard
                retryCount > 0,
                error.isSeleniumError(ofType: .noSuchElement)
            else {
                return false
            }

            let retryCount = retryCount - 1

            sleep(UInt32(durationSeconds))

            return try await waitUntil(locatorType, retryCount: retryCount, durationSeconds: durationSeconds)
        }
    }
}
