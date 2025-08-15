// PostElementDragAndDropRequest.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import AnyCodable
import AsyncHTTPClient
import Foundation
import NIO
import NIOHTTP1

/// A WebDriver request that performs a drag-and-drop operation from one element to another.
///
/// `PostElementDragAndDropRequest` generates the actions payload required by Selenium/WebDriver
/// to simulate dragging a source element to a target element using pointer events.
///
/// Conforms to `RequestType` for use with `APIClient`.
internal struct PostElementDragAndDropRequest: RequestType {
    // MARK: - Associated Types

    /// The expected response type returned by the drag-and-drop request.
    public typealias Response = PostElementClickResponse

    // MARK: - Properties

    /// The base URL of the WebDriver server.
    public var baseURL: URL

    /// The active WebDriver session identifier.
    public var sessionId: String

    /// The element ID of the source element to drag.
    public var elementId: String

    /// The element ID of the target element to drop onto.
    public var toElementId: String

    /// The rectangle representing the size and position of the target element.
    public var targetElementRect: ElementRect

    /// The request path relative to `baseURL`.
    ///
    /// Always `"session/{sessionId}/actions"` for performing drag-and-drop pointer actions.
    public var path: String {
        "session/\(sessionId)/actions"
    }

    /// The HTTP method used for this request.
    ///
    /// Always `.POST` because WebDriver requires POST for actions.
    public var method: HTTPMethod = .POST

    /// The HTTP headers for this request.
    ///
    /// Defaults to an empty header set.
    public var headers: HTTPHeaders = [:]

    /// The HTTP request body containing the encoded pointer actions payload.
    ///
    /// Returns `nil` if encoding the payload fails.
    public var body: HTTPClient.Body? {
        getEncodedActionsPayload()
    }

    // MARK: - Private Helpers

    /// Encodes the actions payload into `HTTPClient.Body`.
    ///
    /// - Returns: Encoded body data or `nil` if encoding fails.
    private func getEncodedActionsPayload() -> HTTPClient.Body? {
        let payload = getActionsPayload()
        guard let data = encodeActionsPayload(payload: payload) else {
            return nil
        }
        return .data(data)
    }

    /// Encodes an `ActionsPayload` object to JSON data.
    ///
    /// - Parameter payload: The payload to encode.
    /// - Returns: Encoded data or `nil` if encoding fails.
    private func encodeActionsPayload(payload: ActionsPayload) -> Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try? encoder.encode(payload)
    }

    /// Constructs the full `ActionsPayload` for the drag-and-drop operation.
    ///
    /// - Returns: An `ActionsPayload` containing pointer actions.
    private func getActionsPayload() -> ActionsPayload {
        ActionsPayload(actions: [getPointerSource()])
    }

    /// Creates a `PointerSource` object representing the mouse pointer for the drag-and-drop.
    ///
    /// - Returns: A `PointerSource` with drag-and-drop actions.
    private func getPointerSource() -> PointerSource {
        PointerSource(
            type: "pointer",
            id: "mouse",
            parameters: .init(pointerType: "mouse"),
            actions: getDragAndDropPointerActions()
        )
    }

    /// Generates the sequence of `PointerAction` objects to perform drag-and-drop.
    ///
    /// - Returns: An array of pointer actions simulating a drag from the source to the target.
    private func getDragAndDropPointerActions() -> [PointerAction] {
        let (origin, dragToOrigin) = getElementOrigins()
        let (targetCenterX, targetCenterY) = getElementCenterCoordinates()

        return [
            PointerAction(type: "pointerMove", origin: origin, x: 0, y: 0),
            PointerAction(type: "pointerDown", button: 0),
            PointerAction(type: "pause", duration: 100),
            PointerAction(type: "pointerMove", origin: dragToOrigin, x: targetCenterX, y: targetCenterY),
            PointerAction(type: "pointerUp", button: 0)
        ]
    }

    /// Calculates the center coordinates of the target element for accurate drop location.
    ///
    /// - Returns: A tuple `(x, y)` representing the center of the target element.
    private func getElementCenterCoordinates() -> (Int, Int) {
        let targetCenterX = Int(targetElementRect.width / 2)
        let targetCenterY = Int(targetElementRect.height / 2)
        return (targetCenterX, targetCenterY)
    }

    /// Returns the WebDriver origins for the source and target elements.
    ///
    /// - Returns: A tuple `(sourceOrigin, targetOrigin)` representing element references.
    private func getElementOrigins() -> (WebDriverElementOrigin, WebDriverElementOrigin) {
        let origin = WebDriverElementOrigin(element: elementId)
        let dragToOrigin = WebDriverElementOrigin(element: toElementId)
        return (origin, dragToOrigin)
    }
}
