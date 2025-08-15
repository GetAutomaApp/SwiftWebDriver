// ActionsPayload.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

/// Represents a complete actions payload to be sent to the WebDriver Actions API.
///
/// Contains one or more input sources (pointer, touch, etc.) with their associated actions.
internal struct ActionsPayload: Encodable {
    /// Array of input sources, each with their pointer actions.
    public let actions: [PointerSource]
}

/// Represents a pointer input source (e.g., mouse) for the WebDriver Actions API.
internal struct PointerSource: Encodable {
    /// Type of input source, usually `"pointer"`.
    public let type: String

    /// Identifier for the input source, e.g., `"mouse"`.
    public let id: String

    /// Parameters describing the input source.
    public let parameters: Parameters

    /// Sequence of pointer actions for this input source.
    public let actions: [PointerAction]

    /// Parameters describing the pointer input source.
    internal struct Parameters: Encodable {
        /// Pointer type, e.g., `"mouse"`, `"pen"`, `"touch"`.
        public let pointerType: String
    }
}

/// Represents a single pointer action for use in the WebDriver Actions API.
///
/// Examples of actions include pointer move, pointer down/up, and pauses.
internal struct PointerAction: Encodable {
    /// The type of the action, e.g., `"pointerMove"`, `"pointerDown"`, `"pointerUp"`, `"pause"`.
    public let type: String

    /// Optional origin element for the action.
    public let origin: WebDriverElementOrigin?

    /// Optional x-coordinate for the pointer action.
    public let x: Int?

    /// Optional y-coordinate for the pointer action.
    public let y: Int?

    /// Optional button for pointer actions (0 = left, 1 = middle, 2 = right).
    public let button: Int?

    /// Optional duration in milliseconds for pause actions.
    public let duration: Int?

    /// Initializes a new `PointerAction`.
    ///
    /// - Parameters:
    ///   - type: The type of pointer action.
    ///   - origin: The element origin for the action (optional).
    ///   - x: X-coordinate (optional).
    ///   - y: Y-coordinate (optional).
    ///   - button: Button index for mouse actions (optional).
    ///   - duration: Duration in milliseconds for pause actions (optional).
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

/// Represents a reference to a WebDriver element in the Actions API.
///
/// This is used as the origin for pointer or touch actions.
internal struct WebDriverElementOrigin: Encodable {
    /// The element ID in WebDriver protocol format.
    public let element: String

    enum CodingKeys: String, CodingKey {
        case element = "element-6066-11e4-a52e-4f735466cecf"
    }
}
