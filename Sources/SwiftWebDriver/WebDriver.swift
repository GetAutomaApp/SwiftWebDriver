// WebDriver.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Foundation
import NIOCore

/// A high-level wrapper around a `Driver` instance to interact with a WebDriver session.
///
/// Provides convenient methods for browser navigation, element interaction, JavaScript execution,
/// and session management.
public class WebDriver<T: Driver> {
    private let driver: T

    /// Initializes a new `WebDriver` instance.
    ///
    /// - Parameter driver: The underlying driver conforming to `Driver` protocol.
    public required init(driver: T) {
        self.driver = driver
    }

    deinit {
        // Clean up resources if needed
    }

    /// Starts the WebDriver session.
    ///
    /// - Returns: The session identifier string.
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func start() async throws -> String {
        try await driver.start()
    }

    /// Stops the WebDriver session.
    ///
    /// - Returns: Optional string indicating stopped session, if applicable.
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func stop() async throws -> String? {
        try await driver.stop()
    }

    /// Retrieves the current status of the WebDriver session.
    ///
    /// - Returns: A `StatusResponse` object describing the session status.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func status() async throws -> StatusResponse {
        try await driver.status()
    }

    /// Retrieves the navigation information of the current session.
    ///
    /// - Returns: A `GetNavigationResponse` object.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func getNavigation() async throws -> GetNavigationResponse {
        try await driver.getNavigation()
    }

    /// Navigates to a specified URL string.
    ///
    /// - Parameter urlString: The URL to load.
    /// - Returns: A `PostNavigationResponse` indicating the result of the navigation.
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func navigateTo(urlString: String) async throws -> PostNavigationResponse {
        try await driver.postNavigation(requestURL: urlString)
    }

    /// Navigates to a specified URL.
    ///
    /// - Parameter url: The `URL` to load.
    /// - Returns: A `PostNavigationResponse` indicating the result of the navigation.
    @discardableResult
    public func navigateTo(url: URL) async throws -> PostNavigationResponse {
        try await navigateTo(urlString: url.absoluteString)
    }

    /// Navigates back in the browser history.
    ///
    /// - Returns: A `PostNavigationBackResponse`.
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func navigationBack() async throws -> PostNavigationBackResponse {
        try await driver.postNavigationBack()
    }

    /// Navigates forward in the browser history.
    ///
    /// - Returns: A `PostNavigationForwardResponse`.
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func navigationForward() async throws -> PostNavigationForwardResponse {
        try await driver.postNavigationForward()
    }

    /// Refreshes the current page.
    ///
    /// - Returns: A `PostNavigationRefreshResponse`.
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func navigationRefresh() async throws -> PostNavigationRefreshResponse {
        try await driver.postNavigationRefresh()
    }

    /// Retrieves the title of the current page.
    ///
    /// - Returns: A `GetNavigationTitleResponse`.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func navigationTitle() async throws -> GetNavigationTitleResponse {
        try await driver.getNavigationTitle()
    }

    /// Finds a single element in the current page.
    ///
    /// - Parameter locatorType: The locator strategy to find the element.
    /// - Returns: An `Element` if found.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func findElement(_ locatorType: LocatorType) async throws -> Element {
        try await driver.findElement(locatorType)
    }

    /// Finds multiple elements in the current page.
    ///
    /// - Parameter locatorType: The locator strategy to find the elements.
    /// - Returns: An array of `Element` objects.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func findElements(_ locatorType: LocatorType) async throws -> Elements {
        try await driver.findElements(locatorType)
    }

    /// Takes a screenshot of the current page.
    ///
    /// - Returns: A base64-encoded PNG string.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func screenshot() async throws -> String {
        try await driver.getScreenShot()
    }

    /// Waits until an element matching the locator appears.
    ///
    /// - Parameters:
    ///   - locatorType: The locator to wait for.
    ///   - retryCount: Number of retry attempts.
    ///   - durationSeconds: Delay between retries in seconds.
    /// - Returns: `true` if the element appears, `false` otherwise.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    @discardableResult
    public func waitUntil(
        _ locatorType: LocatorType,
        retryCount: Int = 3,
        durationSeconds: Int = 1
    ) async throws -> Bool {
        try await driver.waitUntil(locatorType, retryCount: retryCount, durationSeconds: durationSeconds)
    }

    /// Executes JavaScript in the context of the page.
    ///
    /// - Parameters:
    ///   - script: JavaScript code to execute.
    ///   - args: Arguments to pass to the script.
    ///   - type: Execution type (sync or async).
    /// - Returns: A `PostExecuteResponse` with the result.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    @discardableResult
    public func execute(
        _ script: String,
        args: [AnyEncodable] = [],
        type: DevToolTypes.JavascriptExecutionTypes = .sync
    ) async throws -> PostExecuteResponse {
        try await driver.execute(script, args: args, type: type)
    }

    /// Retrieves the currently active element in the page.
    ///
    /// - Returns: The `Element` that is currently active.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    @discardableResult
    public func getActiveElement() async throws -> Element {
        try await driver.getActiveElement()
    }

    /// Sets an attribute on an element.
    ///
    /// - Parameters:
    ///   - element: The target element.
    ///   - attributeName: The attribute name to set.
    ///   - newValue: The new value to assign.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func setAttribute(element: Element, attributeName: String, newValue: String) async throws {
        try await driver.setAttribute(element: element, attributeName: attributeName, newValue: newValue)
    }

    /// Retrieves a property of an element.
    ///
    /// - Parameters:
    ///   - element: The target element.
    ///   - propertyName: The property name to retrieve.
    /// - Returns: A `PostExecuteResponse` with the value.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func getProperty(element: Element, propertyName: String) async throws -> PostExecuteResponse {
        try await driver.getProperty(element: element, propertyName: propertyName)
    }

    /// Sets a property of an element.
    ///
    /// - Parameters:
    ///   - element: The target element.
    ///   - propertyName: The property name to set.
    ///   - newValue: The value to assign.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func setProperty(element: Element, propertyName: String, newValue: String) async throws {
        try await driver.setProperty(element: element, propertyName: propertyName, newValue: newValue)
    }

    /// Drags an element and drops it onto a target element.
    ///
    /// - Parameters:
    ///   - source: The element to drag.
    ///   - target: The element to drop onto.
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func dragAndDrop(from source: Element, to target: Element) async throws {
        try await driver.dragAndDrop(from: source, to: target)
    }
}
