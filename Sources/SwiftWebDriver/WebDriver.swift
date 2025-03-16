//
//  File.swift
//  
//
//  Created by ashizawa on 2022/06/03.
//

import Foundation
import NIOCore

public class WebDriver<T: Driver> {
    
    let driver: T
    
    
    /// init webDriver
    /// - Parameter driver:Driver
    public required init(driver: T) {
        self.driver = driver
    }

    /// webdriver start method
    /// - Returns: session id
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func start() async throws -> String {
        let result = try await driver.start()
        return result
    }

    /// webdriver stop method
    /// - Returns: nil
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func stop() async throws -> String? {
        return try await driver.stop()
    }


    
    /// webdriver status
    /// - Returns: StatusResponse
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func status() async throws -> StatusResponse {
        return try await driver.status()
    }

    
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func getNavigation() async throws -> GetNavigationResponse {
        return try await driver.getNavigation()
    }
    
    
    /// load page
    /// - Parameter url: load page url
    /// - Returns: PostNavigationResponse
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func navigateTo(urlString: String) async throws -> PostNavigationResponse {
        return try await driver.postNavigation(requestURL: urlString)
    }
    
    @discardableResult
    public func navigateTo(url: URL) async throws -> PostNavigationResponse {
        return try await navigateTo(urlString: url.absoluteString)
    }
    
    
    /// navigation back
    /// - Returns: PostNavigationBackResponse
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func navigationBack() async throws -> PostNavigationBackResponse {
        return try await driver.postNavigationBack()
    }
    
    
    /// navigation forward
    /// - Returns: PostNavigationForwardResponse<PostNavigationForwardResponse>
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func navigatonForward() async throws -> PostNavigationForwardResponse {
        return try await driver.postNavigationForward()
    }
    
    
    @discardableResult
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func navigatonRefresh() async throws -> PostNavigationRefreshResponse {
        return try await driver.postNavigationRefresh()
    }
    
    
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func navigationTitle() async throws -> GetNavigationTitleResponse {
        return try await driver.getNavigationTitle()
    }
    
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func findElement(_ locatorType: LocatorType) async throws -> Element {
        return try await driver.findElement(locatorType)
    }
    
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func findElements(_ locatorType: LocatorType) async throws -> Elements {
        return try await driver.findElements(locatorType)
    }
    
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    public func screenshot() async throws -> String {
        return try await driver.getScreenShot()
    }
    
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    @discardableResult
    public func waitUntil(_ locatorType: LocatorType, retryCount: Int = 3, durationSeconds: Int = 1) async throws -> Bool {
        return try await driver.waitUntil(locatorType, retryCount: retryCount, durationSeconds: durationSeconds)
    }
    
    @available(macOS 10.15, iOS 13.0, watchOS 6.0, tvOS 13.0, *)
    @discardableResult
    public func execute(_ script: String, args: [String], type: ExecutionTypes = .sync) async throws -> PostExecuteResponse {
        return try await driver.execute(script, args: args, type: type)
    }

}
