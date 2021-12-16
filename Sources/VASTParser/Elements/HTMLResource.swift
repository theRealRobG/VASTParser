public extension VAST.Element {
    /// A “snippet” of HTML code to be inserted directly within the publisher’s HTML page code.
    struct HTMLResource {
        /// A HTML code snippet (within a CDATA element)
        public let content: String

        public init(content: String) {
            self.content = content
        }
    }
}
