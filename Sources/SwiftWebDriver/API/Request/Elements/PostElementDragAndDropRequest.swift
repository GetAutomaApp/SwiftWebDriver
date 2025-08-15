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
        let origin = WebDriverElementOrigin(element: elementId)
        let dragToOrigin = WebDriverElementOrigin(element: toElementId)

        let targetCenterX = Int(targetElementRect.width / 2)
        let targetCenterY = Int(targetElementRect.height / 2)

        let pointerActions = [
            PointerAction(type: "pointerMove", origin: origin, x: 0, y: 0),
            PointerAction(type: "pointerDown", button: 0),
            PointerAction(type: "pause", duration: 100),
            PointerAction(type: "pointerMove", origin: dragToOrigin, x: targetCenterX, y: targetCenterY),
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
