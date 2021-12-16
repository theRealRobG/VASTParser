public extension VAST.Element {
    /// When an executable file is needed as part of the creative delivery or execution, a
    /// `<CreativeExtensions>` element can be added under the `<Creative>`. This
    /// extension can be used to load an executable creative with or without using the
    /// `<MediaFile>`.
    ///
    /// A `<CreativeExtension>` (singular) element is nested under the
    /// `<CreativeExtensions>` (plural) element so that any XML extensions are separated
    /// from VAST XML. Additionally, any XML used in this extension should identify an XML name
    /// space (xmlns) to avoid confusing any of the extension element names with those of VAST.
    ///
    /// The nested `<CreativeExtension>` includes an attribute for type, which specifies the
    /// MIME type needed to execute the extension.
    struct CreativeExtensions {
        /// Used as a container under the CreativeExtensions element, this node is used to delineate any custom XML
        /// object that might be needed for ad execution.
        public let creativeExtension: [CreativeExtension]

        public init(creativeExtension: [CreativeExtension]) {
            self.creativeExtension = creativeExtension
        }
    }
}
