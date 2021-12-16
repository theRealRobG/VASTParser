public extension VAST.Element {
    /// Ad servers can use this XML node for custom extensions of VAST. When used, custom XML
    /// should fall under the nested `<Extension>` (singular) element so that custom XML can be
    /// separated from VAST elements. An XML namespace (xmlns) should also be used for the
    /// custom extension to separate it from VAST components.
    struct Extensions {
        /// One instance of `<Extension>` should be used for each custom extension. The type attribute is a custom value
        /// which identifies the extension.
        public let `extension`: [Extension]

        public init(extension: [Extension]) {
            self.extension = `extension`
        }
    }
}
