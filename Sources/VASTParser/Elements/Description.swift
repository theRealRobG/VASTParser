public extension VAST.Element {
    /// When a longer description of the ad is needed, the `<Description>` element can be used.
    struct Description {
        /// A string that provides a long ad description
        public let content: String

        public init(content: String) {
            self.content = content
        }
    }
}
