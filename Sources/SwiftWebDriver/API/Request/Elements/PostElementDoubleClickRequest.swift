// PostElementDoubleClickRequest.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import AnyCodable
import AsyncHTTPClient
import Foundation
import NIO
import NIOHTTP1

internal struct PostElementDoubleClickRequest: RequestType {
    typealias Response = PostElementClickResponse

    var baseURL: URL

    var sessionId: String

    var elementId: String

    var path: String {
        "session/\(sessionId)/actions"
    }

    var method: HTTPMethod = .POST

    var headers: HTTPHeaders = [:]

    var body: HTTPClient.Body? {
        let origin = WebDriverElementOrigin(element: elementId)

        let pointerActions = [
            PointerAction(type: "pointerMove", origin: origin, x: 0, y: 0),
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

struct WebDriverElementOrigin: Encodable {
    let element: String

    enum CodingKeys: String, CodingKey {
        case element = "element-6066-11e4-a52e-4f735466cecf"
    }
}

struct PointerAction: Encodable {
    let type: String
    let origin: WebDriverElementOrigin?
    let x: Int?
    let y: Int?
    let button: Int?
    let duration: Int?

    init(
        type: String,
        origin: WebDriverElementOrigin? = nil,
        x: Int? = nil,
        y: Int? = nil,
        button: Int? = nil,
        duration: Int? = nil
    ) {
        self.type = type
        self.origin = origin
        self.x = x
        self.y = y
        self.button = button
        self.duration = duration
    }
}

struct PointerSource: Encodable {
    let type: String
    let id: String
    let parameters: Parameters
    let actions: [PointerAction]

    struct Parameters: Encodable {
        let pointerType: String
    }
}

struct ActionsPayload: Encodable {
    let actions: [PointerSource]
}
