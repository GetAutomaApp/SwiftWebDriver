// StatusResponse.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Foundation

public struct StatusResponse: ResponseType {
    public let value: Value

    public struct Value: ResponseType {
        public let ready: Bool
        public let message: String
    }
}
