//
//  File.swift
//  
//
//  Created by ashizawa on 2022/06/03.
//

import Foundation
import NIO
import NIOHTTP1
import AsyncHTTPClient

protocol StatableOpject: Codable {}

public protocol Driver: FindElementProtocol {
    
    associatedtype BrowserOption
    
    var browserObject: BrowserOption { get }
    
    var url: URL { get }
    
    var sessionId: String? { get }
    
    func start() async throws -> String
    
    func stop() async throws -> String?
    
    func status() async throws -> StatusResponse
    
    func getNavigation() async throws -> GetNavigationResponse
    
    func postNavigation(requestURL: String) async throws -> PostNavigationResponse
    
    func postNavigationBack() async throws -> PostNavigationBackResponse
    
    func postNavigationForward() async throws -> PostNavigationForwardResponse
    
    func postNavigationRefresh() async throws -> PostNavigationRefreshResponse
    
    func getNavigationTitle() async throws -> GetNavigationTitleResponse
    
    func getScreenShot() async throws -> String
    
    func waitUntil(_ locatorType: LocatorType, retryCount: Int, durationSeconds: Int) async throws -> Bool
    
    func executeJavascriptSync(_ script: String, args: [String]) async throws -> PostExecuteSyncResponse
}
