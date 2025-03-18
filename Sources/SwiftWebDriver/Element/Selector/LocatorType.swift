//
//  File.swift
//  
//
//  Created by ashizawa on 2022/06/06.
//

import Foundation

public enum LocatorType: Sendable {
    case css(_ cssSelector: CSSSelector)
    case xpath(_ path: String)
    case linkText(_ linkText: String)
    case partialLinkText(_ particlalLinText: String)
    case tagName(_ tagName: String)
    
    internal func create() -> LocatorSelector {
        switch self {
        case .css(let cssSelectorType):
            return cssSelectorType.create()
        case .xpath(let value):
            return LocatorSelector(using: "xpath", value: value)
        case .linkText(let value):
            return LocatorSelector(using: "link text", value: value)
        case .partialLinkText(let value):
            return LocatorSelector(using: "partial link text", value: value)
        case .tagName(let value):
            return LocatorSelector(using: "tag name", value: value)
        }
    }
}
