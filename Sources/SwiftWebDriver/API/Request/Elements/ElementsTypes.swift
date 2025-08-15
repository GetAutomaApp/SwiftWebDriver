// ElementsTypes.swift
// Copyright (c) 2025 GetAutomaApp
// All source code and related assets are the property of GetAutomaApp.
// All rights reserved.

/// A namespace containing type definitions related to HTML elements and input interactions.
///
/// `ElementsTypes` serves as a grouping for various subtypes used when interacting
/// with elements, such as keyboard input key codes.
public enum ElementsTypes {
    /// Represents special key codes that can be sent to an element when performing a `sendKeys`-type action.
    ///
    /// These key codes use WebDriver's Unicode-based representation for non-text keys
    /// such as `Enter`, `Return`, and `Tab`. They can be sent along with regular
    /// text input to simulate keyboard events in browser automation.
    public enum SendValueActionKeyTypes: String {
        /// The **Enter** key (Unicode: `\u{E007}`).
        ///
        /// Typically used to submit forms or trigger button actions in web pages.
        case ENTER1 = "\u{E007}"

        /// The **Return** key (Unicode: `\u{E006}`).
        ///
        /// Often treated similarly to `Enter`, but provided as a separate code
        /// for systems that distinguish between them.
        case RETURN1 = "\u{E006}"

        /// The **Tab** key (Unicode: `\u{E004}`).
        ///
        /// Used to move focus between interactive elements (e.g., form fields) in a web page.
        case TAB = "\u{E004}"

        /// The raw Unicode representation of the key.
        ///
        /// This string value is what will be sent to the WebDriver `sendKeys`
        /// command when simulating a key press.
        public var unicode: String {
            rawValue
        }
    }
}
