public extension VAST.Element {
    /// Used as a container under the CreativeExtensions element, this node is used to delineate any custom XML
    /// object that might be needed for ad execution.
    struct CreativeExtension {
        /// Custom XML object
        public let content: Any
        /// The MIME type of any code that might be included in the extension.
        public let type: String

        public init(content: Any, type: String) {
            self.content = content
            self.type = type
        }
    }
}
