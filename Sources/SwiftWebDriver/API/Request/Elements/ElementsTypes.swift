// ElementsTypes.swift
// Copyright (c) 2026 GetAutomaApp
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

        case NULL = "\u{E000}"
        case CANCEL = "\u{E001}"
        case HELP = "\u{E002}"
        case BACKSPACE = "\u{E003}"
        case CLEAR = "\u{E005}"
        case SHIFT = "\u{E008}"
        case CONTROL = "\u{E009}"
        case ALT = "\u{E00A}"
        case PAUSE = "\u{E00B}"
        case ESCAPE = "\u{E00C}"
        case SPACE = "\u{E00D}"
        case PAGE_UP = "\u{E00E}"
        case PAGE_DOWN = "\u{E00F}"
        case END = "\u{E010}"
        case HOME = "\u{E011}"
        case LEFT_ARROW = "\u{E012}"
        case UP_ARROW = "\u{E013}"
        case RIGHT_ARROW = "\u{E014}"
        case DOWN_ARROW = "\u{E015}"
        case INSERT = "\u{E016}"
        case DELETE = "\u{E017}"
        case F1 = "\u{E031}"
        case F2 = "\u{E032}"

        /// The raw Unicode representation of the key.
        ///
        /// This string value is what will be sent to the WebDriver `sendKeys`
        /// command when simulating a key press.
        public var unicode: String {
            rawValue
        }
    }
}
