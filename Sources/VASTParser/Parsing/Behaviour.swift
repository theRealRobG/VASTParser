public extension VAST.Parsing {
    class Behaviour {
        public let defaults: DefaultConstants
        public let strictness: Strictness

        public init(
            defaults: DefaultConstants = DefaultConstants(),
            strictness: Strictness = .default
        ) {
            self.defaults = defaults
            self.strictness = strictness
        }
    }
}
