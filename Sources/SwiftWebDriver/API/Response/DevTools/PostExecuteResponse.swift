// PostExecuteResponse.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import AnyCodable
import Foundation

public struct PostExecuteResponse: ResponseType {
    public let value: AnyCodableValue?
}
