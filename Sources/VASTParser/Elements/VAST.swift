public extension VAST.Element {
    struct VAST {
        /// A float (number with decimal) to indicate the VAST version being used.
        public let version: Double
        /// Either `<Error>` or `<Ad>` may be provided but not both
        public let children: VAST.Children

        public init(version: Double, children: VAST.Children) {
            self.version = version
            self.children = children
        }
    }
}

public extension VAST.Element.VAST {
    enum Children {
        case error([VAST.Element.Error])
        case ad([VAST.Element.Ad])
    }
}
