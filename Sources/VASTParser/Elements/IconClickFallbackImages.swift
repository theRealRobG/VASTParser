public extension VAST.Element {
    /// The `<IconClickFallbackImages>` element is used to provide information disclosure for platforms which do not
    /// support HTML rendering, by baking the information into an image. This is a fallback for when the buyer
    /// cannot rely on `<IconClickThrough>` for disclosure. When an icon click occurs, the ad must pause and the
    /// image must be rendered above the video. The player must provide a means for the user to close the dialogue,
    /// for example by pressing the back button. The image must not be obstructed and should not be downloaded
    /// unless a click-action occurs.
    struct IconClickFallbackImages {
        /// The `<IconClickFallbackImage>` element is used to display information when an icon click occurs.
        public let iconClickFallbackImage: [IconClickFallbackImage]

        public init(iconClickFallbackImage: [IconClickFallbackImage]) {
            self.iconClickFallbackImage = iconClickFallbackImage
        }
    }
}
