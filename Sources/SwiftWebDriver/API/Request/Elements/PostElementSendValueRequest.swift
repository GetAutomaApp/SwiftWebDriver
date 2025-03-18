//
//  File.swift
//  
//
//  Created by ashizawa on 2022/06/10.
//

import Foundation
import AsyncHTTPClient
import NIOHTTP1
import NIO

internal struct PostElementSendValueRequest: RequestType {
    
    typealias Response = PostElementSendValueResponse
    
    var baseURL: URL
    
    var sessionId: String
    
    var elementId: String
    
    var path: String {
        "session/\(sessionId)/element/\(elementId)/value"
    }
    
    let method: HTTPMethod = .POST
    
    var text: String
    
    var headers: HTTPHeaders = [:]
    
    var body: HTTPClient.Body? {
        
        let reqeustBody = PostElementSendValueRequest
            .RequestBody(text: text)
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(reqeustBody)
        
        guard let data = data else {
            return nil
        }

        return .data(data)
    }
}

extension PostElementSendValueRequest {
    struct RequestBody: Codable {
        let text: String
    }
}

public enum SpecialKey: String {
    case RETURN1 = "\u{E006}"
    case ENTER1 = "\u{E007}"
    case TAB = "\u{E004}"
    
    var unicode: String {
        return self.rawValue
    }
}

