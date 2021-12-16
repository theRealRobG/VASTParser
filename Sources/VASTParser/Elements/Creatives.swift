public extension VAST.Element {
    /// The `<Creatives>` (plural) element is a container for one or more `<Creative>` (singular)
    /// element used to provide creative files for the ad. For an InLine ad, the `<Creatives>` element
    /// nests all the files necessary for executing and tracking the ad.
    ///
    /// In a Wrapper, elements nested under `<Creatives>` are used mostly for tracking. Companion
    /// and Icon creative may be included in a Wrapper, but files for Linear and NonLinear ads can only be
    /// provided in the InLine version of the ad.
    struct Creatives {
        /// Each `<Creative>` element contains nested elements that describe the type of ad being
        /// served using nested sub-elements. Multiple creatives may be used to define different
        /// components of the ad. At least one `<Linear>` element is required under the Creative
        /// element.
        public let creative: [Creative]

        public init(creative: [Creative]) {
            self.creative = creative
        }
    }
}
