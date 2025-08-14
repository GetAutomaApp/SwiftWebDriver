// ActionsPayload.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

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
