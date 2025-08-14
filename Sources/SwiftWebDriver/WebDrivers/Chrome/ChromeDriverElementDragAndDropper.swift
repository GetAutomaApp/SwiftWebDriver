// ChromeDriverElementDragAndDropper.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

internal struct ChromeDriverElementDragAndDropper {
    let source: Element
    let target: Element
    let driver: ChromeDriver

    public init(driver: ChromeDriver, from source: Element, to target: Element) {
        self.driver = driver
        self.source = source
        self.target = target
    }

    public func dragAndDrop() async throws {
        if try await isHTML5Draggable() {
            try await simulateHTML5DragAndDrop()
        } else {
            try await source.dragAndDrop(to: target)
        }
    }

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

    private func isHTML5Draggable() async throws -> Bool {
        guard
            let draggableValue = try? await source.attribute(name: "draggable")
        else {
            return false
        }
        return draggableValue.lowercased() == "true"
    }
}
