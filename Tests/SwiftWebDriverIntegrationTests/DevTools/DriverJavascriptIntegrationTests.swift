// DriverJavascriptIntegrationTests.swift
// Copyright (c) 2026 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

import Foundation
@testable import SwiftWebDriver
import Testing

internal enum JavascriptIntegrationTestCases {
    static let syncExecution: [(script: String, expected: String)] = [
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
        ("document.body.innerHTML = '<p>Hello, World!</p>'; return document.body.innerText", "Hello, World!")
    ]

    static let asyncExecution: [(script: String, expected: String)] = [
        (
            """
            var callback = arguments[arguments.length - 1];
            setTimeout(function() { callback('Hello from async JavaScript'); }, 2000);
            """,
            "Hello from async JavaScript"
        )
    ]
}

internal class DriverJavascriptIntegrationTestBase<Configuration: DriverTestConfiguration>:
    DriverIntegrationTest<Configuration>
{
    internal func runExecuteJavascriptTest(input: (script: String, expected: String)) async throws {
        try await driver.navigateTo(url: testPageURL)

        let output = try await driver.execute(input.script, args: [])

        #expect(output.value?.stringValue == input.expected)
    }

    internal func runExecuteAsyncJavascriptTest(input: (script: String, expected: String)) async throws {
        try await driver.navigateTo(url: testPageURL)

        let output = try await driver.execute(
            input.script,
            args: [],
            type: .async
        )

        #expect(output.value?.stringValue == input.expected)
    }

    internal func runThrowSeleniumErrorTest() async throws {
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
    }
}

@Suite("Chrome Driver Javascript Integration Tests", .serialized)
internal final class ChromeDriverJavascriptIntegrationTests:
    DriverJavascriptIntegrationTestBase<ChromeTestConfiguration>
{
    @Test(
        "Test sync Javascript Execution",
        arguments: JavascriptIntegrationTestCases.syncExecution
    )
    internal func executeJavascript(input: (script: String, expected: String)) async throws {
        try await runExecuteJavascriptTest(input: input)
    }

    @Test(
        "Test async Javascript Execution",
        arguments: JavascriptIntegrationTestCases.asyncExecution
    )
    internal func executeAsyncJavascript(input: (script: String, expected: String)) async throws {
        try await runExecuteAsyncJavascriptTest(input: input)
    }

    @Test("Throws `javascript error` if JS fails")
    internal func throwSeleniumError() async throws {
        try await runThrowSeleniumErrorTest()
    }
}

@Suite("Firefox Driver Javascript Integration Tests", .serialized)
internal final class FirefoxDriverJavascriptIntegrationTests:
    DriverJavascriptIntegrationTestBase<FirefoxTestConfiguration>
{
    @Test(
        "Test sync Javascript Execution",
        arguments: JavascriptIntegrationTestCases.syncExecution
    )
    internal func executeJavascript(input: (script: String, expected: String)) async throws {
        try await runExecuteJavascriptTest(input: input)
    }

    @Test(
        "Test async Javascript Execution",
        arguments: JavascriptIntegrationTestCases.asyncExecution
    )
    internal func executeAsyncJavascript(input: (script: String, expected: String)) async throws {
        try await runExecuteAsyncJavascriptTest(input: input)
    }

    @Test("Throws `javascript error` if JS fails")
    internal func throwSeleniumError() async throws {
        try await runThrowSeleniumErrorTest()
    }
}
