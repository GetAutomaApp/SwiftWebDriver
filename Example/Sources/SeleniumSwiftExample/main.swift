// // main.swift
// // Copyright (c) 2025 GetAutomaApp
// // All source code and related assets are the property of GetAutomaApp.
// // All rights reserved.
// //
// // This package is freely distributable under the MIT license.
// // This Package is a modified fork of https://github.com/ashi-psn/SwiftWebDriver.

// import SwiftWebDriver

// let chromeOption = try ChromeOptions(
//     args: [
//         Args(.headless),
//     ]
// )

// let chromeDriver = try ChromeDriver(
//     driverURLString: "http://localhost:9515",
//     browserObject: chromeOption
// )

// let driver = WebDriver(
//     driver: chromeDriver
// )

// Task.detached {
//     do {
//         let status = try await driver.status()
//         print(status)
//         let sessionId = try await driver.start()
//         print(sessionId)
//         try await driver.stop()
//     } catch {
//         print(error)
//     }
// }
