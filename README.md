# SwiftWebDriver
[![Docker Image CI](https://github.com/ashi-psn/SwiftWebDriver/actions/workflows/main.yml/badge.svg)](https://github.com/ashi-psn/SwiftWebDriver/actions/workflows/main.yml)
[![Release](https://img.shields.io/github/v/release/ashi-psn/SwiftWebDriver)](https://github.com/ashi-psn/SwiftWebDriver/releases/latest)
[![Swift Compatibility](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fashi-psn%2FSwiftWebDriver%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/ashi-psn/SwiftWebDriver)
[![Platform Compatibility](https://img.shields.io/endpoint?url=https://swiftpackageindex.com/api/packages/ashi-psn/SwiftWebDriver/badge?type=platforms)](https://swiftpackageindex.com/ashi-psn/SwiftWebDriver)


This library allows you to work with selenium webdriver on server-side swift


## Getting Started
Adding the dependency

Add the following entry in your Package.swift to start using SwiftWebDriver:

```swift
.package(url: "https://github.com/GetAutomaApp/SwiftWebDriver.git", branch: "master)
```

and add dependency to your target:
```Swift
.target(name: "MyApp", dependencies: [.product(name: "SwiftWebDriver", package: "SwiftWebDriver")]),

```

# Testing in Docker

```bash
docker-compose build // build image
docker-compose up -d // Run httpd and chromedriver
docker-compose run test // Run Tests in Docker
```


# Example
### Start snd Stop

```Swift
let chromeOption = ChromeOptions(
  args: [
    Args(.headless),
  ]
)

// create webdriver object
// default webdriver url is http://localhost:4444
// if you need to change webdriver url, use `driverURL` parameter.
let driver = WebDriver(
  driver: ChromeDriver(
    browserObject: chromeOption
    )
)


//create session
let sessionId = try await driver.start()

//stop session
try await driver.stop()
```
---
### Find Elements
#### Use Element Selector

```Swift
// find element by class name
let classText = try await driver.findElement(.css(.class("classElement")))

// find element by id name
let idElement = try await driver.findElement(.css(.id("idElement")))

// find element by name parameter
let nameElement = try await driver.findElement(.css(.name("nameElement")))
```

#### Use XPath

```Swift
let element = try await driver.findElement(.xpath("//*[@id=\"inParentSingleElement\"]"))
```

#### Use Link Text

```Swift
let element = try await driver.findElement(.linkText("go to next page"))
```

#### Use PartialLink

```Swift
let element = try await driver.findElement(.partialLinkText("go"))
```

#### Use Find Elements Method

Both Selectors support the findElements Method.
findElements method return Elements, such as Array<Element>.


---
### Get Element Value
Element.text method return value.

```Swift
let text = try await driver
  .findElement(.css(.id("myValue")))
  .text()
```

---
### Element Chain Method
Elements and Elements can use chain methods to narrow down the elements

```Swift
let element = try await driver
  .findElement(.css(.id("parent"))
  .findElement(.css(.id("child")))
  .text()
```
