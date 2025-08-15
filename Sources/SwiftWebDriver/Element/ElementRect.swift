// ElementRect.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

public struct ElementRect: Codable, Sendable {
    public let xPosition: Double
    public let yPosition: Double
    public let width: Double
    public let height: Double

    public enum CodingKeys: String, CodingKey {
        case xPosition = "x"
        case yPosition = "y"
        case width
        case height
    }
}
