public extension VAST.Element {
    /// The `<IconClicks>` element is a container for `<IconClickThrough>` and `<ClickTracking>`.
    struct IconClicks {
        /// `<IconClickTracking>` is used to track click activity within the icon.
        public let iconClickTracking: [IconClickTracking]
        /// A URI to the industry program page opened when a viewer clicks the icon.
        ///
        /// The `<IconClickThrough>` is used to provide a URI to the industry program page that the media player opens
        /// when the icon is clicked.
        public let iconClickThrough: IconClickThrough?
        /// The `<IconClickFallbackImages>` element is used to provide information disclosure for platforms which do not
        /// support HTML rendering, by baking the information into an image. This is a fallback for when the buyer
        /// cannot rely on `<IconClickThrough>` for disclosure. When an icon click occurs, the ad must pause and the
        /// image must be rendered above the video. The player must provide a means for the user to close the dialogue,
        /// for example by pressing the back button. The image must not be obstructed and should not be downloaded
        /// unless a click-action occurs.
        public let iconClickFallbackImages: IconClickFallbackImages?

        public init(
            iconClickTracking: [IconClickTracking],
            iconClickThrough: IconClickThrough?,
            iconClickFallbackImages: IconClickFallbackImages?
        ) {
            self.iconClickTracking = iconClickTracking
            self.iconClickThrough = iconClickThrough
            self.iconClickFallbackImages = iconClickFallbackImages
        }
    }
}
