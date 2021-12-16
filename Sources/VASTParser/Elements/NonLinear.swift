public extension VAST.Element {
    /// Each `<NonLinear>` element may provide different versions of the same creative using the `<StaticResource>`,
    /// `<IFrameResource>`, and `<HTMLResource>` elements in the InLine VAST response. In a Wrapper response, only
    /// tracking elements may be provided.
    struct NonLinear {
        /// The pixel width of the placement slot for which the creative is intended.
        public let width: Int
        /// The pixel height of the placement slot for which the creative is intended.
        public let height: Int
        /// The URI to a static creative file to be used for the ad component identified in the parent element, which is
        /// either: `<NonLinear>`, `<Companion>`, or `<Icon>`.
        public let staticResource: [StaticResource]
        /// The URI to an HTML resource file to be loaded into an iframe by the publisher. Associated with the ad
        /// component identified in the parent element, which is either: `<NonLinear>`, `<Companion>`, or `<Icon>`.
        public let iFrameResource: [IFrameResource]
        /// A “snippet” of HTML code to be inserted directly within the publisher’s HTML page code.
        public let htmlResource: [HTMLResource]
        /// Some ad serving systems may want to send data to the media file when first initialized. For example, the
        /// media file may use ad server data to identify the context used to display the creative, what server to talk
        /// to, or even which creative to display. The optional `<AdParameters>` element for the Linear creative enables
        /// this data exchange.
        ///
        /// The optional attribute `xmlEncoded` is available for the `<AdParameters>` element to identify whether the ad
        /// parameters are xml-encoded. If true, the media player can only decode the data using XML. Media players
        /// operating on earlier versions of VAST may not be able to XML-decode data, so data should only be xml-encoded
        /// when being served to media players capable of XML-decoding the data.
        ///
        /// When a VAST response is used to serve a VPAID ad unit, the `<AdParameters>` element is currently the only
        /// way to pass information from the VAST response into the VPAID object; no other mechanism is provided.
        public let adParameters: AdParameters?
        /// When the NonLinear ad creative handles the clickthrough in an InLine ad, the `<NonLinearClickTracking>`
        /// element is used to track the click, provided the ad has a way to notify the player that that ad was clicked,
        /// such as when using a VPAID ad unit. The NonLinearClickTracking element is also used to track clicks in
        /// Wrappers.
        ///
        /// NonLinearClickTracking might be used for an InLine ad when:
        ///   - Any static resource file where the media player handles the click, such as when “playerHandles=true” in
        ///     a VPAID AdClickThru event.
        ///
        /// NonLinearClickTracking is used in a Wrapper Ad in the following situations:
        ///   - Static image file
        ///   - Flash file with no API framework (deprecated)
        ///   - Flash file in which apiFramework=clickTAG (deprecated)
        ///   - Any static resource file where the media player handles the click, such as when “playerHandles=true” in
        ///     a VPAID AdClickThru event
        public let nonLinearClickTracking: [NonLinearClickTracking]
        /// Most NonLinear creative can provide a clickthrough of their own, but in the case where the creative cannot
        /// provide a clickthrough, such as with a simple static image, the `<NonLinearClickThrough>` element can be
        /// used to provide the clickthrough.
        ///
        /// A clickthrough may need to be provided for an InLine ad in the following situations:
        ///   - Static image file
        ///   - Any static resource file where the media player handles the click, such as when “playerHandles=true” in
        ///     a VPAID AdClickThru event.
        public let nonLinearClickThrough: NonLinearClickThrough?
        /// An optional identifier for the creative.
        public let id: String?
        /// The maximum pixel width of the creative in its expanded state.
        public let expandedWidth: Int?
        /// The maximum pixel height of the creative in its expanded state.
        public let expandedHeight: Int?
        /// Identifies whether the creative can scale to new dimensions relative to the video player when the video
        /// player is resized
        public let scalable: Bool?
        /// Identifies whether the aspect ratio of the creative should be maintained when it is scaled to new dimensions
        /// as the video player is resized
        public let maintainAspectRatio: Bool?
        /// The API necessary to communicate with the creative if available.
        public let apiFramework: String?
        /// The minimum suggested duration that the creative should be displayed; duration is in the format
        /// `HH:MM:SS.mmm` (where .mmm is in milliseconds and is optional)
        public let minSuggestedDuration: DurationString?

        public init(
            width: Int,
            height: Int,
            staticResource: [StaticResource],
            iFrameResource: [IFrameResource],
            htmlResource: [HTMLResource],
            adParameters: AdParameters?,
            nonLinearClickTracking: [NonLinearClickTracking],
            nonLinearClickThrough: NonLinearClickThrough?,
            id: String?,
            expandedWidth: Int?,
            expandedHeight: Int?,
            scalable: Bool?,
            maintainAspectRatio: Bool?,
            apiFramework: String?,
            minSuggestedDuration: DurationString?
        ) {
            self.width = width
            self.height = height
            self.staticResource = staticResource
            self.iFrameResource = iFrameResource
            self.htmlResource = htmlResource
            self.adParameters = adParameters
            self.nonLinearClickTracking = nonLinearClickTracking
            self.nonLinearClickThrough = nonLinearClickThrough
            self.id = id
            self.expandedWidth = expandedWidth
            self.expandedHeight = expandedHeight
            self.scalable = scalable
            self.maintainAspectRatio = maintainAspectRatio
            self.apiFramework = apiFramework
            self.minSuggestedDuration = minSuggestedDuration
        }
    }
}
