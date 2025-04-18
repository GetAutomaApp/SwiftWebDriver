// ChromeDriverJavascriptIntegrationTests.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.
//
// This package is freely distributable under the MIT license.
// This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

import Foundation
@testable import SwiftWebDriver
import Testing

@Suite("Chrome Driver Javascript Sync", .serialized)
internal class ChromeDriverJavascriptIntegrationTests: ChromeDriverTest {
    @Test("Test sync Javascript Execution", arguments: [
        ("return `${1 + 2}`", "3"),
        ("return `${5 - 3}`", "2"),
        ("return `${3 * 4}`", "12"),
        ("return `${10 / 2}`", "5"),
        ("return `Hello, ` + 'World!'", "Hello, World!"),
        ("localStorage.setItem('user', 'John'); return localStorage.getItem('user')", "John"),
        ("localStorage.setItem('token', 'abc123'); return localStorage.getItem('token')", "abc123"),
        ("sessionStorage.setItem('session', 'active'); return sessionStorage.getItem('session')", "active"),
        ("let arr = [1, 2, 3]; arr.push(4); return arr.join(',')", "1,2,3,4"),
        ("let obj = { name: 'Alice', age: 25 }; obj.age = 26; return `${obj.age}`", "26"),
        ("document.body.innerHTML = '<p>Hello, World!</p>'; return document.body.innerText", "Hello, World!"),
    ])
    public func executeJavascript(input: (String, String)) async throws {
        try await driver.navigateTo(url: testPageURL)
        let output = try await driver.execute(input.0, args: [])
        #expect(output.value?.stringValue == input.1)

        try await driver.stop()
    }

    @Test("Test async Javascript Execution", arguments: [
        (
            """
            var callback = arguments[arguments.length - 1];
            setTimeout(function() { callback('Hello from async JavaScript'); }, 2000);
            """,
            "Hello from async JavaScript"
        ),
    ])
    public func executeAsyncJavascript(input: (String, String)) async throws {
        try await driver.navigateTo(url: testPageURL)
        let output = try await driver.execute(
            input.0,
            args: [],
            type: .async
        )
        #expect(output.value?.stringValue == input.1)

        try await driver.stop()
    }

    @Test("Throws `javascript error` if JS fails")
    public func throwSeleniumError() async throws {
        do {
            try await driver.navigateTo(url: testPageURL)
            try await driver.execute("throw new Error('Test Error')", args: [])
            try #require(Bool(false))
        } catch {
            guard error.isSeleniumError(ofType: .javascriptError) else {
                try #require(Bool(false))
                return
            }
        }

        try await driver.stop()
    }

    deinit {
        // Add deinit logic here
    }
}
