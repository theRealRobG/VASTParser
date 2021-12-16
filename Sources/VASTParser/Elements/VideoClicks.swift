public extension VAST.Element {
    /// The `<VideoClicks>` element provides URIs for `clickthroughs`, `clicktracking`, and `custom` clicks and is
    /// available for Linear Ads in both the InLine and Wrapper formats. Both InLine and Wrapper formats offer the
    /// ClickThrough, ClickTracking and CustomClick elements. These elements are defined in the following sections.
    struct VideoClicks {
        /// The `<ClickThrough>` is a URI to the advertiser’s site that the media player opens when a viewer clicks the
        /// ad. The clickthrough is available in the InLine and Wrapper formats and is used when the Linear ad unit
        /// cannot handle a clickthrough.
        public let clickThrough: ClickThrough?
        /// Multiple `<ClickTracking>` elements can be used in the case where multiple parties would like to track the
        /// Linear ad clickthrough.
        public let clickTracking: [ClickTracking]
        /// The `<CustomClick>` is used to track any interactions with the linear ad that do not include the
        /// clickthrough click and do not take the viewer away from the media player. For example, if an ad vendor wants
        /// to track that a viewer clicked a button to change the ad's background color, the `<CustomClick>` element
        /// holds the URI to notify the ad vendor that this click happened. An API may be needed to inform the player
        /// that a click occurred and that the corresponding URI should be activated.
        public let customClick: [CustomClick]

        public init(
            clickThrough: ClickThrough?,
            clickTracking: [ClickTracking],
            customClick: [CustomClick]
        ) {
            self.clickThrough = clickThrough
            self.clickTracking = clickTracking
            self.customClick = customClick
        }
    }
}
