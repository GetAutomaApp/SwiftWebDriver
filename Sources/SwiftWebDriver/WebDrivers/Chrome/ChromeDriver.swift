// ChromeDriver.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

import AsyncHTTPClient
import Foundation
import NIO
import NIOHTTP1

public class ChromeDriver: Driver {
    public typealias BrowserOption = ChromeOptions

    public var browserObject: ChromeOptions

    public var url: URL

    private let client = APIClient.shared

    public var sessionId: String?

    public required init(driverURL url: URL, browserObject: ChromeOptions) {
        self.url = url
        self.browserObject = browserObject
    }

    public convenience init(
        driverURLString urlString: String = "http://localhost:4444",
        browserObject: ChromeOptions
    ) throws {
        guard let url = URL(string: urlString) else {
            throw HTTPClientError.invalidURL
        }
        self.init(driverURL: url, browserObject: browserObject)
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func start() async throws -> String {
        // swiftlint:disable:next prefer_self_in_static_references
        let id = try await ChromeDriver.startDriverExternal(url: url, browserObject: browserObject, client: client)
        sessionId = id
        return id
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func stop() async throws -> String? {
        guard let sessionId else {
            throw WebDriverError.sessionIdIsNil
        }
        let request = DeleteSessionRequest(baseURL: url, sessionId: sessionId)
        return try await client.request(request).map(\.value).get()
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func status() async throws -> StatusResponse {
        let request = StatusRequest(baseURL: url)
        return try await client.request(request).get()
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func getNavigation() async throws -> GetNavigationResponse {
        guard let sessionId else {
            throw WebDriverError.sessionIdIsNil
        }
        let request = GetNavigationRequest(baseURL: url, sessionId: sessionId)
        return try await client.request(request).get()
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func postNavigation(requestURL: String) async throws -> PostNavigationResponse {
        guard let sessionId else {
            throw WebDriverError.sessionIdIsNil
        }
        let request = PostNavigationRequest(baseURL: url, sessionId: sessionId, requestURL: requestURL)
        return try await client.request(request).get()
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func postNavigationBack() async throws -> PostNavigationBackResponse {
        guard let sessionId else {
            throw WebDriverError.sessionIdIsNil
        }
        let request = PostNavigationBackRequest(baseURL: url, sessionId: sessionId)
        return try await client.request(request).get()
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func postNavigationForward() async throws -> PostNavigationForwardResponse {
        guard let sessionId else {
            throw WebDriverError.sessionIdIsNil
        }
        let request = PostNavigationForwardRequest(baseURL: url, sessionId: sessionId)
        return try await client.request(request).get()
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func postNavigationRefresh() async throws -> PostNavigationRefreshResponse {
        guard let sessionId else {
            throw WebDriverError.sessionIdIsNil
        }
        let request = PostNavigationRefreshRequest(baseURL: url, sessionId: sessionId)
        return try await client.request(request).get()
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func getNavigationTitle() async throws -> GetNavigationTitleResponse {
        guard let sessionId else {
            throw WebDriverError.sessionIdIsNil
        }
        let request = GetNavigationTitleRequest(baseURL: url, sessionId: sessionId)
        return try await client.request(request).get()
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func postElement(locatorSelector: LocatorSelector) async throws -> PostElementResponse {
        guard let sessionId else {
            throw WebDriverError.sessionIdIsNil
        }
        let request = PostElementRequest(baseURL: url, sessionId: sessionId, cssSelector: locatorSelector)
        return try await client.request(request).get()
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func postElements(locatorSelector: LocatorSelector) async throws -> PostElementsResponse {
        guard let sessionId else {
            throw WebDriverError.sessionIdIsNil
        }
        let request = PostElementsRequest(baseURL: url, sessionId: sessionId, cssSelector: locatorSelector)
        return try await client.request(request).get()
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func postElementByElementId(
        locatorSelector: LocatorSelector,
        elementId: String
    ) async throws -> PostElementByIdResponse {
        guard let sessionId else {
            throw WebDriverError.sessionIdIsNil
        }
        let request = PostElementByIdRequest(
            baseURL: url,
            sessionId: sessionId,
            elementId: elementId,
            cssSelector: locatorSelector
        )
        return try await client.request(request).get()
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func postElementsByElementId(
        locatorSelector: LocatorSelector,
        elementId: String
    ) async throws -> PostElementsByIdResponse {
        guard let sessionId else {
            throw WebDriverError.sessionIdIsNil
        }
        let request = PostElementsByIdRequest(
            baseURL: url,
            sessionId: sessionId,
            elementId: elementId,
            cssSelector: locatorSelector
        )
        return try await client.request(request).get()
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func getElementText(elementId: String) async throws -> GetElementTextResponse {
        guard let sessionId else {
            throw WebDriverError.sessionIdIsNil
        }
        let request = GetElementTextRequest(baseURL: url, sessionId: sessionId, elementId: elementId)
        return try await client.request(request).get()
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func getElementName(elementId: String) async throws -> GetElementNameResponse {
        guard let sessionId else {
            throw WebDriverError.sessionIdIsNil
        }
        let request = GetElementNameRequest(baseURL: url, sessionId: sessionId, elementId: elementId)
        return try await client.request(request).get()
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func findElement(_ locatorType: LocatorType) async throws -> Element {
        guard let sessionId else {
            throw WebDriverError.sessionIdIsNil
        }
        let request = PostElementRequest(baseURL: url, sessionId: sessionId, cssSelector: locatorType.create())
        let response = try await client.request(request)
        return Element(baseURL: url, sessionId: sessionId, elementId: response.elementId)
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func findElements(_ locatorType: LocatorType) async throws -> Elements {
        guard let sessionId else {
            throw WebDriverError.sessionIdIsNil
        }
        let request = PostElementsRequest(baseURL: url, sessionId: sessionId, cssSelector: locatorType.create())
        let response = try await client.request(request)
        return response.value.map { elementId in
            Element(baseURL: url, sessionId: sessionId, elementId: elementId)
        }
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func getScreenShot() async throws -> String {
        guard let sessionId else {
            throw WebDriverError.sessionIdIsNil
        }
        let request = GetScreenShotRequest(baseURL: url, sessionId: sessionId)
        let response = try await client.request(request)
        return response.value
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    @discardableResult
    public func waitUntil(
        _ locatorType: LocatorType,
        retryCount: Int = 3,
        durationSeconds: Int = 1
    ) async throws -> Bool {
        guard let sessionId else {
            throw WebDriverError.sessionIdIsNil
        }
        let request = PostElementRequest(baseURL: url, sessionId: sessionId, cssSelector: locatorType.create())

        do {
            try await client.request(request)
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

    private func executeJavascriptSync(_ script: String, args: [String]) async throws -> PostExecuteResponse {
        guard let sessionId else {
            throw WebDriverError.sessionIdIsNil
        }

        let request = PostExecuteSyncRequest(
            baseURL: url,
            sessionId: sessionId,
            javascriptSnippet: .init(script: script, args: args)
        )

        return try await client.request(request)
    }

    private func executeJavascriptAsync(_ script: String, args: [String]) async throws -> PostExecuteResponse {
        guard let sessionId else {
            throw WebDriverError.sessionIdIsNil
        }

        let request = PostExecuteAsyncRequest(
            baseURL: url,
            sessionId: sessionId,
            javascriptSnippet: .init(script: script, args: args)
        )

        return try await client.request(request)
    }

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    @discardableResult
    public func execute(
        _ script: String,
        args: [String],
        type: DevToolTypes.JavascriptExecutionTypes
    ) async throws -> PostExecuteResponse {
        try await type == .sync ?
            executeJavascriptSync(script, args: args) :
            executeJavascriptAsync(
                script,
                args: args
            )
    }

    public func getActiveElement() async throws -> Element {
        guard let sessionId else {
            throw WebDriverError.sessionIdIsNil
        }

        let request = GetSessionActiveElementRequest(baseURL: url, sessionId: sessionId)

        let response = try await client.request(request)
        return Element(baseURL: url, sessionId: sessionId, elementId: response.elementId)
    }

    deinit {
        let url = url
        let sessionId = sessionId
        Task {
            guard let sessionId else { return }
            // swiftlint:disable:next prefer_self_in_static_references
            try await ChromeDriver.stopDriverExternal(url: url, sessionId: sessionId)
        }
    }

    // NOTE: Due to swift 6 race-condition prevention we can't call the ChromeDriver.stop method
    // This function just acts as a middleman to ensure the de initialization automatically closes the session
    private static func stopDriverExternal(url: URL, sessionId: String) async throws {
        let request = DeleteSessionRequest(baseURL: url, sessionId: sessionId)
        _ = try await APIClient.shared.request(request).map(\.value).get()
    }

    private static func startDriverExternal(
        url: URL,
        browserObject: ChromeOptions,
        client: APIClient
    ) async throws -> String {
        let request = NewSessionRequest(baseURL: url, chromeOptions: browserObject)
        return try await client.request(request).map(\.value.sessionId).get()
    }
}
