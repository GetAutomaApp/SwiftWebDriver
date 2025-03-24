// WebDriver.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

import Foundation
import NIOCore

public class WebDriver<T: Driver> {
    let driver: T

    /// init webDriver
    /// - Parameter driver:Driver
    public required init(driver: T) {
        self.driver = driver
    }

    /// webdriver start method
    /// - Returns: session id
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func start() async throws -> String {
        let result = try await driver.start()
        return result
    }

    /// webdriver stop method
    /// - Returns: nil
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func stop() async throws -> String? {
        try await driver.stop()
    }

    /// webdriver status
    /// - Returns: StatusResponse
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func status() async throws -> StatusResponse {
        try await driver.status()
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func getNavigation() async throws -> GetNavigationResponse {
        try await driver.getNavigation()
    }

    /// load page
    /// - Parameter url: load page url
    /// - Returns: PostNavigationResponse
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func navigateTo(urlString: String) async throws -> PostNavigationResponse {
        try await driver.postNavigation(requestURL: urlString)
    }

    @discardableResult
    public func navigateTo(url: URL) async throws -> PostNavigationResponse {
        try await navigateTo(urlString: url.absoluteString)
    }

    /// navigation back
    /// - Returns: PostNavigationBackResponse
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func navigationBack() async throws -> PostNavigationBackResponse {
        try await driver.postNavigationBack()
    }

    /// navigation forward
    /// - Returns: PostNavigationForwardResponse<PostNavigationForwardResponse>
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func navigationForward() async throws -> PostNavigationForwardResponse {
        try await driver.postNavigationForward()
    }

    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func navigationRefresh() async throws -> PostNavigationRefreshResponse {
        try await driver.postNavigationRefresh()
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func navigationTitle() async throws -> GetNavigationTitleResponse {
        try await driver.getNavigationTitle()
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func findElement(_ locatorType: LocatorType) async throws -> Element {
        try await driver.findElement(locatorType)
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func findElements(_ locatorType: LocatorType) async throws -> Elements {
        try await driver.findElements(locatorType)
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func screenshot() async throws -> String {
        try await driver.getScreenShot()
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    @discardableResult
    public func waitUntil(_ locatorType: LocatorType, retryCount: Int = 3,
                          durationSeconds: Int = 1) async throws -> Bool
    {
        try await driver.waitUntil(locatorType, retryCount: retryCount, durationSeconds: durationSeconds)
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    @discardableResult
    public func execute(_ script: String, args: [String] = [],
                        type: JavascriptExecutionTypes = .sync) async throws -> PostExecuteResponse
    {
        try await driver.execute(script, args: args, type: type)
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    @discardableResult
    public func getActiveElement() async throws -> Element {
        try await driver.getActiveElement()
    }
}
