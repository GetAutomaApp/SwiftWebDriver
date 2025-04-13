// Elements.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

import Foundation

public typealias Elements = [Element]

public extension Elements {
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    private func texts() async throws -> [String] {
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

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    private func names() async throws -> [String] {
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

    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    private func findElement(_ locatorType: LocatorType) async throws -> Elements {
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

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    private func findElements(_ locatorType: LocatorType) async throws -> Elements {
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

    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    @discardableResult
    private func waitUntil(
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
