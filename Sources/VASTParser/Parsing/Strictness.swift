public extension VAST.Parsing {
    struct Strictness: OptionSet {
        public static let allowDefaultRequiredConstants = Strictness(rawValue: 1 << 0)
        public static let allowDefaultRequiredElements = Strictness(rawValue: 1 << 1)
        public static let allowUnexpectedElementStarts = Strictness(rawValue: 1 << 2)
        public static let allowUnexpectedElementEnds = Strictness(rawValue: 1 << 3)

        public static let `default`: Strictness = [
            .allowUnexpectedElementStarts,
            .allowUnexpectedElementEnds
        ]
        public static let loose: Strictness = [
            .allowUnexpectedElementStarts,
            .allowUnexpectedElementEnds,
            .allowDefaultRequiredElements,
            .allowDefaultRequiredConstants
        ]
        public static let strict: Strictness = []

        public let rawValue: Int

        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }
}
