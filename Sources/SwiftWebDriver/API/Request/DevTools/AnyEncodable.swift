// AnyEncodable.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

/// A type-erased wrapper for any `Encodable` value.
///
/// `AnyEncodable` allows you to store or pass around values of different `Encodable`
/// types without knowing their concrete type at compile time. This is useful when
/// building heterogeneous collections of `Encodable` objects or creating dynamic
/// JSON payloads.
public struct AnyEncodable: Encodable {
    // MARK: - Private Properties

    /// The internal closure used to encode the wrapped value.
    private let encodeFunc: (Encoder) throws -> Void

    // MARK: - Initializers

    /// Creates a type-erased wrapper around the given `Encodable` value.
    ///
    /// - Parameter value: Any value that conforms to `Encodable`.
    public init(_ value: some Encodable) {
        encodeFunc = value.encode
    }

    // MARK: - Encoding

    /// Encodes the wrapped value using the given encoder.
    ///
    /// - Parameter encoder: The encoder to write data to.
    /// - Throws: Any encoding error thrown by the wrapped value.
    public func encode(to encoder: Encoder) throws {
        try encodeFunc(encoder)
    }
}
