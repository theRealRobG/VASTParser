public extension VAST.Element {
    /// The AltText element is used to provide a description of the companion creative when an ad viewer mouses over
    /// the ad.
    struct AltText {
        /// A string to describe the creative when an ad viewer mouses over the ad.
        public let content: String

        public init(content: String) {
            self.content = content
        }
    }
}
