public extension VAST.Element {
    /// One instance of `<Extension>` should be used for each custom extension. The type attribute is a custom value
    /// which identifies the extension.
    struct Extension {
        /// Custom XML object
        public let content: Any
        /// A string that identifies the type of extension.
        public let type: String

        public init(content: Any, type: String) {
            self.content = content
            self.type = type
        }
    }
}
