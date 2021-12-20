public extension VAST.Element {
    /// Nested under the `<Icons>` element, the Icon is used to provide one or more creative files for the icon that
    /// represents the program being implemented along with any icon tracking elements. Multiple `<Icon>` elements
    /// may be used to represent multiple programs.
    struct Icon {
        /// The URI to a static creative file to be used for the ad component identified in the parent element, which is
        /// either: `<NonLinear>`, `<Companion>`, or `<Icon>`.
        public let staticResource: [StaticResource]
        /// A URI to the iframe creative file to be used for the ad component identified in the parent element.
        ///
        /// The URI to an HTML resource file to be loaded into an iframe by the publisher. Associated with the ad
        /// component identified in the parent element, which is either: `<NonLinear>`, `<Companion>`, or `<Icon>`.
        public let iFrameResource: [IFrameResource]
        /// A HTML code snippet (within a CDATA element)
        ///
        /// A “snippet” of HTML code to be inserted directly within the publisher’s HTML page code.
        public let htmlResource: [HTMLResource]
        /// A URI for the tracking resource file to be called when the icon creative is displayed.
        ///
        /// The view tracking for icons is used to track when the icon creative is displayed. The player uses the
        /// included URI to notify the icon server when the icon has been displayed.
        public let iconViewTracking: [IconViewTracking]
        /// The `<IconClicks>` element is a container for `<IconClickThrough>` and `<ClickTracking>`.
        public let iconClicks: IconClicks?
        /// The program represented in the icon (e.g. "AdChoices").
        public let program: String?
        /// Pixel width of the icon asset.
        public let width: Int?
        /// Pixel height of the icon asset.
        public let height: Int?
        /// The x-coordinate of the top, left corner of the icon asset relative to the ad display area. Values of "left"
        /// or "right" also accepted and indicate the leftmost or rightmost available position for the icon asset.
        public let xPosition: Double?
        /// The y-coordinate of the top left corner of the icon asset relative to the ad display area; values of "top"
        /// or "bottom" also accepted and indicate the topmost or bottommost available position for the icon asset.
        public let yPosition: Double?
        /// The duration the icon should be displayed unless clicked or ad is finished playing; provided in the format
        /// HH:MM:SS.mmm or HH:MM:SS where .mmm is milliseconds and optional.
        public let duration: DurationString?
        /// The time of delay from when the associated linear creative begins playing to when the icon should be
        /// displayed; provided in the format HH:MM:SS.mmm or HH:MM:SS.
        public let offset: DurationString?
        /// Identifies the API needed to execute the icon resource file if applicable.
        public let apiFramework: String?
        /// The pixel ratio for which the icon creative is intended. The pixel ratio is the ratio of physical pixels on
        /// the device to the device-independent pixels. An ad intended for display on a device with a pixel ratio that
        /// is twice that of a standard 1:1 pixel ratio would use the value "2 " Default value is "1 ".
        public let pxratio: String?
        /// Alternative text for the image. In an html5 image tag this should be the text for the alt attribute. This
        /// should enable screen readers to properly read back a description of the icon for visually impaired users.
        public let altText: String?
        /// Hover text for the image. In an html5 image tag this should be the text for the title attribute.
        public let hoverText: String?

        public init(
            staticResource: [StaticResource],
            iFrameResource: [IFrameResource],
            htmlResource: [HTMLResource],
            iconViewTracking: [IconViewTracking],
            iconClicks: IconClicks?,
            program: String?,
            width: Int?,
            height: Int?,
            xPosition: Double?,
            yPosition: Double?,
            duration: DurationString?,
            offset: DurationString?,
            apiFramework: String?,
            pxratio: String?,
            altText: String?,
            hoverText: String?
        ) {
            self.staticResource = staticResource
            self.iFrameResource = iFrameResource
            self.htmlResource = htmlResource
            self.iconViewTracking = iconViewTracking
            self.iconClicks = iconClicks
            self.program = program
            self.width = width
            self.height = height
            self.xPosition = xPosition
            self.yPosition = yPosition
            self.duration = duration
            self.offset = offset
            self.apiFramework = apiFramework
            self.pxratio = pxratio
            self.altText = altText
            self.hoverText = hoverText
        }
    }
}
