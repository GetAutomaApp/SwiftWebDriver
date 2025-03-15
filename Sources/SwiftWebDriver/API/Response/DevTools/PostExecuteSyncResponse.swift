//
//  PostExecute.swift
//  swift-webdriver
//
//  Created by Simon Ferns on 3/15/25.
//
import Foundation
import AnyCodable

public struct PostExecuteSyncResponse: Codable {
    let value: AnyCodableValue
}
