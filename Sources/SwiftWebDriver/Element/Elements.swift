// Elements.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Foundation

/// A type alias for an array of `Element` instances.
///
/// `Elements` is used to represent multiple DOM elements returned by queries
/// such as `findElements` or batch operations.
public typealias Elements = [Element]

/// Extension adding convenience methods for working with multiple `Element` instances.
///
/// These methods are designed for batch operations, allowing asynchronous actions
/// (like retrieving text or attributes) to be performed concurrently on each element.
public extension Elements {
    /// Retrieves the visible text content of each element in the collection.
    ///
    /// This method performs requests concurrently for all elements and returns
    /// their `innerText` values in the same order they complete (not necessarily
    /// the order they appear in the array).
    ///
    /// - Returns: An array of strings, each representing an element's visible text.
    /// - Throws: An error if any of the underlying WebDriver requests fail.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    func texts() async throws -> [String] {
        var ids: [String] = []
        try await withThrowingTaskGroup(of: GetElementTextResponse.self) { group in
            for element in self {
                let request = GetElementTextRequest(
                    baseURL: element.baseURL,
                    sessionId: element.sessionId,
                    elementId: element.elementId
                )

                group.addTask {
                    try await APIClient.shared.request(request)
                }
            }
            for try await element in group {
                ids.append(element.value)
            }
        }

        return ids
    }

    /// Retrieves the tag name of each element in the collection.
    ///
    /// This method performs requests concurrently for all elements.
    ///
    /// - Returns: An array of strings containing each element's tag name.
    /// - Throws: An error if any of the underlying WebDriver requests fail.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    func names() async throws -> [String] {
        var names: [String] = []
        try await withThrowingTaskGroup(of: GetElementNameResponse.self) { group in
            for element in self {
                let request = GetElementNameRequest(
                    baseURL: element.baseURL,
                    sessionId: element.sessionId,
                    elementId: element.elementId
                )

                group.addTask {
                    try await APIClient.shared.request(request)
                }
            }
            for try await element in group {
                names.append(element.value)
            }
        }

        return names
    }

    /// Finds the first matching descendant element within each element in the collection.
    ///
    /// This is equivalent to calling `findElement(_:)` on each element, and it runs all lookups concurrently.
    ///
    /// - Parameter locatorType: The method by which to locate the element (e.g., `.css`, `.xpath`).
    /// - Returns: An array of found `Element` instances.
    /// - Throws: An error if no matching element is found or if a WebDriver request fails.
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    func findElement(_ locatorType: LocatorType) async throws -> Elements {
        var elements: Elements = []
        try await withThrowingTaskGroup(of: Element.self) { group in
            for element in self {
                group.addTask {
                    try await element.findElement(locatorType)
                }
            }

            for try await element in group {
                elements.append(element)
            }
        }

        return elements
    }

    /// Finds all matching descendant elements within each element in the collection.
    ///
    /// This is equivalent to calling `findElements(_:)` on each element, and it runs all lookups concurrently.
    ///
    /// - Parameter locatorType: The method by which to locate the elements (e.g., `.css`, `.xpath`).
    /// - Returns: A flattened array containing all matching `Element` instances.
    /// - Throws: An error if the WebDriver request fails.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    func findElements(_ locatorType: LocatorType) async throws -> Elements {
        var elements = [Elements]()
        try await withThrowingTaskGroup(of: Elements.self) { group in
            for element in self {
                group.addTask {
                    try await element.findElements(locatorType)
                }
            }
            for try await responseElements in group {
                elements.append(responseElements)
            }
        }

        return elements.flatMap(\.self)
    }

    /// Waits until at least one matching descendant element is found within each element in the collection.
    ///
    /// This method retries the search until a match is found, the retry count is exceeded,
    /// or an error other than `noSuchElement` is encountered.
    ///
    /// - Parameters:
    ///   - locatorType: The method by which to locate the element.
    ///   - retryCount: The maximum number of retries before giving up. Defaults to `3`.
    ///   - durationSeconds: The delay between retries in seconds. Defaults to `1`.
    /// - Returns: `true` if an element was found within the retry limit, otherwise `false`.
    /// - Throws: Any error thrown by `findElement(_:)` that is not a `noSuchElement` Selenium error.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    @discardableResult
    func waitUntil(
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
            else { return false }

            let retryCount = retryCount - 1

            sleep(UInt32(durationSeconds))

            return try await waitUntil(locatorType, retryCount: retryCount, durationSeconds: durationSeconds)
        }
    }
}
