// ElementRect.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

/// Represents the position and size of a DOM element.
///
/// The `ElementRect` struct contains the element's coordinates and dimensions
/// as reported by the WebDriver API. This is typically used for layout measurements,
/// drag-and-drop calculations, and other geometry-based interactions.
///
/// - Note: Coordinates are expressed in CSS pixels relative to the top-left corner
///   of the document's viewport.
public struct ElementRect: Codable, Sendable {
    /// The horizontal position of the element's top-left corner, in CSS pixels.
    public let xPosition: Double

    /// The vertical position of the element's top-left corner, in CSS pixels.
    public let yPosition: Double

    /// The width of the element, in CSS pixels.
    public let width: Double

    /// The height of the element, in CSS pixels.
    public let height: Double

    /// Coding keys for mapping WebDriver's JSON response to Swift property names.
    ///
    /// WebDriver typically returns `"x"` and `"y"` for coordinates,
    /// which are mapped here to `xPosition` and `yPosition` respectively.
    public enum CodingKeys: String, CodingKey {
        case xPosition = "x"
        case yPosition = "y"
        case width
        case height
    }
}
