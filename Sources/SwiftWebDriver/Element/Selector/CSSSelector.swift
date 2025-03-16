//
//  File.swift
//  
//
//  Created by ashizawa on 2022/06/06.
//

import Foundation

public enum CSSSelector: Sendable {
    case id(_ value: String)
    case `class`(_ value: String)
    case name(_ value: String)
    
    // FIXME: 1class のような数字から始まるcssセレクターが数値値として扱われてだめっぽい
    internal func create() -> LocatorSelector {
        switch self {
        case .id(let value):
            return LocatorSelector(using: "css selector", value: "#\(value)")
        case .class(let value):
            return LocatorSelector(using: "css selector", value: ".\(value)")
        case .name(let value):
            return LocatorSelector(using: "css selector", value: "[name=\(value)]")
        }
    }
}
