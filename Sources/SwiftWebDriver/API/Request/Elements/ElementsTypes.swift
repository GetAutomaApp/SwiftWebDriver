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
        case ALT = "\u{E00A}"
        case BACKSPACE = "\u{E003}"
        case CANCEL = "\u{E001}"
        case CLEAR = "\u{E005}"
        case CONTROL = "\u{E009}"
        case DELETE = "\u{E017}"
        case DOWNARROW = "\u{E015}"
        case END = "\u{E010}"
        case ENTER1 = "\u{E007}"
        case ESCAPE = "\u{E00C}"
        case FKEY1 = "\u{E031}"
        case FKEY2 = "\u{E032}"
        case HELP = "\u{E002}"
        case HOME = "\u{E011}"
        case INSERT = "\u{E016}"
        case LEFTARROW = "\u{E012}"
        case NULL = "\u{E000}"
        case PAGEDOWN = "\u{E00F}"
        case PAGEUP = "\u{E00E}"
        case PAUSE = "\u{E00B}"
        case RETURN1 = "\u{E006}"
        case RIGHTARROW = "\u{E014}"
        case SHIFT = "\u{E008}"
        case SPACE = "\u{E00D}"
        case TAB = "\u{E004}"
        case UPARROW = "\u{E013}"

        /// The raw Unicode representation of the key.
        ///
        /// This string value is what will be sent to the WebDriver `sendKeys`
        /// command when simulating a key press.
        public var unicode: String {
            rawValue
        }
    }
}
