import VASTParser

extension VAST.Parsing.AnyElementParser {
    /// Conenience factory method for a parser with loose strictness.
    /// - Returns: A parser with loose parsing strictness.
    static func loose() -> VAST.Parsing.AnyElementParser<T> {
        VAST.Parsing.AnyElementParser(behaviour: VAST.Parsing.Behaviour(strictness: .loose))
    }
}
