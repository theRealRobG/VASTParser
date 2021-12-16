public extension VAST.Element {
    /// The `<IconClickFallbackImage>` element is used to display information when an icon click occurs.
    struct IconClickFallbackImage {
        /// Pixel width of the image asset
        public let width: Int
        /// Pixel height of the image asset
        public let height: Int
        /// The URI to a static creative file to be used for the ad component identified in the parent element, which is
        /// either: `<NonLinear>`, `<Companion>`, or `<Icon>`.
        public let staticResource: [StaticResource]
        /// The AltText element is used to provide a description of the companion creative when an ad viewer mouses over
        /// the ad.
        public let altText: AltText?

        public init(
            width: Int,
            height: Int,
            staticResource: [StaticResource],
            altText: AltText?
        ) {
            self.width = width
            self.height = height
            self.staticResource = staticResource
            self.altText = altText
        }
    }
}
