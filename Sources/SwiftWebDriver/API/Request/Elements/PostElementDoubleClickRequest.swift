// PostElementDoubleClickRequest.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import AnyCodable
import AsyncHTTPClient
import Foundation
import NIO
import NIOHTTP1

/// A WebDriver request that performs a **double-click** action on a specific element.
///
/// This request sends a sequence of pointer actions to the remote WebDriver session
/// to simulate two consecutive mouse clicks on the same element, effectively triggering
/// a double-click event in the browser.
///
/// Conforms to `RequestType` so it can be executed by the API client and return a
/// `PostElementClickResponse` upon completion.
public struct PostElementDoubleClickRequest: RequestType {
    // MARK: - Associated Types

    /// The expected response type for this request.
    ///
    /// A `PostElementClickResponse` is returned by the WebDriver server
    /// after the double-click action has been successfully performed.
    public typealias Response = PostElementClickResponse

    // MARK: - Properties

    /// The base URL of the WebDriver server.
    ///
    /// Typically points to the running browser automation instance
    /// (e.g., `http://localhost:9515` for ChromeDriver).
    public var baseURL: URL

    /// The active WebDriver session identifier.
    ///
    /// This is used to scope the request to a specific browser session.
    public var sessionId: String

    /// The identifier of the target element to double-click.
    ///
    /// This ID must have been obtained from a previous element lookup request.
    public var elementId: String

    /// The request path relative to `baseURL`.
    ///
    /// Combines the session ID with the `/actions` endpoint, which is used for
    /// sending complex user input commands to WebDriver.
    public var path: String {
        "session/\(sessionId)/actions"
    }

    /// The HTTP method for this request.
    ///
    /// Always `.POST` for WebDriver action sequences.
    public var method: HTTPMethod = .POST

    /// The HTTP headers for this request.
    ///
    /// Defaults to an empty header set, allowing `Content-Type` and others to be
    /// applied automatically by the HTTP client.
    public var headers: HTTPHeaders = [:]

    /// The HTTP request body containing the encoded pointer action sequence.
    ///
    /// The body includes:
    /// - A pointer move to the element's origin
    /// - A click (pointer down + pointer up)
    /// - A short pause
    /// - Another click (pointer down + pointer up)
    ///
    /// This sequence simulates a user performing a double-click with a mouse.
    public var body: HTTPClient.Body? {
        let origin = WebDriverElementOrigin(element: elementId)

        let pointerActions = [
            PointerAction(type: "pointerMove", origin: origin, xCoordinate: 0, yCoordinate: 0),
            PointerAction(type: "pointerDown", button: 0),
            PointerAction(type: "pointerUp", button: 0),
            PointerAction(type: "pause", duration: 50),
            PointerAction(type: "pointerDown", button: 0),
            PointerAction(type: "pointerUp", button: 0)
        ]

        let pointerSource = PointerSource(
            type: "pointer",
            id: "mouse",
            parameters: .init(pointerType: "mouse"),
            actions: pointerActions
        )

        let payload = ActionsPayload(actions: [pointerSource])

        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(payload)

        guard let data else {
            return nil
        }

        return .data(data)
    }
}
