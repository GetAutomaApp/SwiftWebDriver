// Driver.swift
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

public protocol Driver: FindElementProtocol {
    associatedtype BrowserOption

    var browserObject: BrowserOption { get }

    var url: URL { get }

    var sessionId: String? { get }

    func start() async throws -> String

    func stop() async throws -> String?

    func status() async throws -> StatusResponse

    func getNavigation() async throws -> GetNavigationResponse

    func postNavigation(requestURL: String) async throws -> PostNavigationResponse

    func postNavigationBack() async throws -> PostNavigationBackResponse

    func postNavigationForward() async throws -> PostNavigationForwardResponse

    func postNavigationRefresh() async throws -> PostNavigationRefreshResponse

    func getNavigationTitle() async throws -> GetNavigationTitleResponse

    func getScreenShot() async throws -> String

    func waitUntil(_ locatorType: LocatorType, retryCount: Int, durationSeconds: Int) async throws -> Bool

    func execute(
        _ script: String,
        args: [AnyEncodable],
        type: DevToolTypes.JavascriptExecutionTypes
    ) async throws -> PostExecuteResponse

    func getActiveElement() async throws -> Element

    func setAttribute(element: Element, attributeName: String, newValue: String) async throws
}
