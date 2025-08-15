// PostElementDragAndDropRequest.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import AnyCodable
import AsyncHTTPClient
import Foundation
import NIO
import NIOHTTP1

internal struct PostElementDragAndDropRequest: RequestType {
    typealias Response = PostElementClickResponse

    var baseURL: URL

    var sessionId: String

    var elementId: String

    var toElementId: String

    var targetElementRect: ElementRect

    var path: String {
        "session/\(sessionId)/actions"
    }

    var method: HTTPMethod = .POST

    var headers: HTTPHeaders = [:]

    var body: HTTPClient.Body? {
        getEncodedActionsPayload()
    }

    private func getEncodedActionsPayload() -> HTTPClient.Body? {
        let payload = getActionsPayload()

        guard
            let data = encodeActionsPayload(payload: payload)
        else {
            return nil
        }

        return .data(data)
    }

    private func encodeActionsPayload(payload: ActionsPayload) -> Data? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try? encoder.encode(payload)
    }

    private func getActionsPayload() -> ActionsPayload {
        ActionsPayload(actions: [getPointerSource()])
    }

    private func getPointerSource() -> PointerSource {
        PointerSource(
            type: "pointer",
            id: "mouse",
            parameters: .init(pointerType: "mouse"),
            actions: getDragAndDropPointerActions()
        )
    }

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

    private func getElementCenterCoordinates() -> (Int, Int) {
        let targetCenterX = Int(targetElementRect.width / 2)
        let targetCenterY = Int(targetElementRect.height / 2)
        return (targetCenterX, targetCenterY)
    }

    private func getElementOrigins() -> (WebDriverElementOrigin, WebDriverElementOrigin) {
        let origin = WebDriverElementOrigin(element: elementId)
        let dragToOrigin = WebDriverElementOrigin(element: toElementId)
        return (origin, dragToOrigin)
    }
}
