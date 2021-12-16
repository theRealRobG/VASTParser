public extension VAST.Element {
    /// The ad serving party must provide a title for the ad using the `<AdTitle>` element. If a longer
    /// description is needed, the `<Description>` element can be used.
    struct AdTitle {
        /// A string that provides a common name for the ad
        public let content: String

        public init(content: String) {
            self.content = content
        }
    }
}
