public extension VAST.Element {
    /// Companion Ads are secondary ads included in the VAST tag that accompany the video/audio ad. The `<CompanionAds>`
    /// element is a container for one or more `<Companion>` elements, where each Companion element provides the
    /// creative files and tracking details. Companion Ads, including any creative, may be included in both InLine and
    /// Wrapper formatted VAST ads.
    struct CompanionAds {
        /// Both InLine and Wrapper VAST responses may contain multiple companion items where each one may contain one
        /// or more creative resource files using the elements: `StaticResource`, `IFrameResource`, and `HTMLResource`.
        /// Each `<Companion>` element may provide different versions of the same creative.
        public let companion: [Companion]
        /// Accepts one of the following values: “all” “any” or “none.”
        ///
        /// The required attribute for the `<CompanionAds>` element provides information about which Companion creative
        /// to display when multiple Companions are supplied and whether the ad can be displayed without its Companion
        /// creative. The value for required can be one of three values: all, any, or none.
        ///
        /// The expected behavior for displaying Companion ads depends on the following values:
        ///   - **all:** the media player must attempt to display the contents for all `<Companion>` elements provided.
        ///     If all companion creative cannot be displayed, the ad should be disregarded and the ad server should be
        ///     notified using the `<Error>` element.
        ///   - **any:** the media player must attempt to display content from at least one of the `<Companion>`
        ///     elements provided (i.e. display the one with dimensions that best fit the page). If none of the
        ///     companion creative can be displayed, the ad should be disregarded and the ad server should be notified
        ///     using the `<Error>` element.
        ///   - **none:** the media player may choose to not display any of the companion creative, but is not
        ///     restricted from doing so. The ad server may use this option when the advertiser prefers that the master
        ///     Linear or NonLinear ad be displayed even if the companion cannot be displayed.
        ///
        /// If not provided, the media player can choose to display content from any or none of the `<Companion>`
        /// elements.
        public let required: Required

        public init(companion: [Companion], required: Required) {
            self.companion = companion
            self.required = required
        }
    }
}

public extension VAST.Element.CompanionAds {
    enum Required: String {
        /// the media player must attempt to display the contents for all `<Companion>` elements provided. If all
        /// companion creative cannot be displayed, the ad should be disregarded and the ad server should be notified
        /// using the `<Error>` element.
        case all
        /// the media player must attempt to display content from at least one of the `<Companion>` elements provided
        /// (i.e. display the one with dimensions that best fit the page). If none of the companion creative can be
        /// displayed, the ad should be disregarded and the ad server should be notified using the `<Error>` element.
        case any
        /// the media player may choose to not display any of the companion creative, but is not restricted from doing
        /// so. The ad server may use this option when the advertiser prefers that the master Linear or NonLinear ad be
        /// displayed even if the companion cannot be displayed.
        case none
    }
}
