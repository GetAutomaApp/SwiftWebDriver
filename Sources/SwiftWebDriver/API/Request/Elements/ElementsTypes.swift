public enum SendValueActionKeyTypes: String {
    case RETURN1 = "\u{E006}"
    case ENTER1 = "\u{E007}"
    case TAB = "\u{E004}"

    var unicode: String {
        return rawValue
    }
}
