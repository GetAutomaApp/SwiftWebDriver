// ChromeDriverElementDragAndDropper.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

/// Handles drag-and-drop operations between two elements in a ChromeDriver session.
///
/// `ChromeDriverElementDragAndDropper` determines whether an element is HTML5-draggable.
/// If it is, it simulates the drag-and-drop using JavaScript events. Otherwise, it
/// falls back to the standard WebDriver `dragAndDrop` method.
///
/// This struct is intended for internal use with ChromeDriver automation.
internal struct ChromeDriverElementDragAndDropper {
    // MARK: - Properties

    /// The source element to drag.
    private let source: Element

    /// The target element to drop onto.
    private let target: Element

    /// The ChromeDriver instance used to execute JavaScript or WebDriver commands.
    private let driver: ChromeDriver

    // MARK: - Initializer

    /// Creates a new drag-and-drop helper for the given elements and driver.
    ///
    /// - Parameters:
    ///   - driver: The ChromeDriver instance that will perform the drag-and-drop.
    ///   - source: The element to be dragged.
    ///   - target: The element to drop onto.
    public init(driver: ChromeDriver, from source: Element, to target: Element) {
        self.driver = driver
        self.source = source
        self.target = target
    }

    // MARK: - Public Methods

    /// Performs the drag-and-drop operation between the source and target elements.
    ///
    /// If the source element is HTML5-draggable, the drag-and-drop is simulated
    /// using JavaScript. Otherwise, it uses the standard WebDriver `dragAndDrop`.
    ///
    /// - Throws: Any errors thrown during attribute lookup, JavaScript execution,
    ///           or WebDriver drag-and-drop operations.
    public func dragAndDrop() async throws {
        if try await isHTML5Draggable() {
            try await simulateHTML5DragAndDrop()
        } else {
            try await source.dragAndDrop(to: target)
        }
    }

    // MARK: - Private Methods

    /// Simulates an HTML5 drag-and-drop operation using JavaScript events.
    ///
    /// Dispatches `dragstart`, `dragover`, and `drop` events on the source and target
    /// elements to mimic a user performing drag-and-drop in the browser.
    ///
    /// - Throws: Any errors thrown by the ChromeDriver JavaScript execution.
    private func simulateHTML5DragAndDrop() async throws {
        let script = """
        function simulateHTML5DragAndDrop(source, target) {
            const dataTransfer = new DataTransfer();

            const dragStartEvent = new DragEvent('dragstart', {
                bubbles: true,
                cancelable: true,
                dataTransfer: dataTransfer
            });
            source.dispatchEvent(dragStartEvent);

            const dragOverEvent = new DragEvent('dragover', {
                bubbles: true,
                cancelable: true,
                dataTransfer: dataTransfer
            });
            target.dispatchEvent(dragOverEvent);

            const dropEvent = new DragEvent('drop', {
                bubbles: true,
                cancelable: true,
                dataTransfer: dataTransfer
            });
            target.dispatchEvent(dropEvent);
        }
        simulateHTML5DragAndDrop(arguments[0], arguments[1]);
        """
        let arguments: [AnyEncodable] = [
            AnyEncodable(["element-6066-11e4-a52e-4f735466cecf": source.elementId]),
            AnyEncodable(["element-6066-11e4-a52e-4f735466cecf": target.elementId])
        ]
        try await driver.execute(script, args: arguments, type: .sync)
    }

    /// Determines whether the source element is HTML5-draggable.
    ///
    /// Checks the `draggable` attribute of the element and returns `true` if its
    /// value is `"true"` (case-insensitive). Returns `false` if the attribute
    /// is missing or has a different value.
    ///
    /// - Returns: `true` if the element supports HTML5 drag-and-drop; otherwise `false`.
    /// - Throws: Any errors thrown when accessing the element's attributes via WebDriver.
    private func isHTML5Draggable() async throws -> Bool {
        guard
            let draggableValue = try? await source.attribute(name: "draggable")
        else {
            return false
        }
        return draggableValue.lowercased() == "true"
    }
}
