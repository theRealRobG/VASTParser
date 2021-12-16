public extension VAST.Element {
    /// Both InLine and Wrapper VAST responses may contain multiple companion items where each one may contain one
    /// or more creative resource files using the elements: `StaticResource`, `IFrameResource`, and `HTMLResource`.
    /// Each `<Companion>` element may provide different versions of the same creative.
    struct Companion {
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
        /// When the companion ad creative handles the clickthrough in an InLine ad, the CompanionClickTracking element
        /// is used to track the click, provided the ad has a way to notify the player that that ad was clicked, such as
        /// when using a VPAID ad unit. The CompanionClickTracking element is also used in Wrappers to track clicks that
        /// occur for the Companion creative in the InLine ad that is returned after one or more wrappers.
        ///
        /// CompanionClickTracking might be used for an InLine ad when:
        ///   - Any static resource file where the media player handles the click, such as when “playerHandles=true” in
        ///     a VPAID AdClickThru event
        ///
        /// CompanionClickTracking is used in a Wrapper in the following situations:
        ///   - Static image file. Any static resource file where the media player handles the click, such as when
        ///     “playerHandlesClick=true” in VPAID
        ///   - Any static resource file where the media player handles the click, such as when
        ///     “playerHandlesClick=true” in VPAID
        public let companionClickTracking: [CompanionClickTracking]
        /// The renderingMode attribute accepts a few values. The publisher player/SDK has control of which of these
        /// renderingMode values are supported and this should be communicated as part of the publisher ad format specs.
        ///
        /// **Companion as End-Card**
        ///
        /// A value of "end-card" signals to the player that this companion ad is meant to be shown after the video
        /// stops playing. The end-card should match the dimensions of the preceding video. If the companion width and
        /// height are not zero, the player may use these values to infer the aspect ratio of the companion ad.
        ///
        /// Companion duration is a new consideration for the end-card and assumed to be controlled by the publisher
        /// player/SDK and communicated as part of the publisher ad format specs. Known variations in market include an
        /// “infinite” duration, which requires the viewer to close the end-card after it is shown, and a timed
        /// duration. For any companion that suspends content playback, such as an in-stream ad, and does not include a
        /// time-out, the player/SDK must implement a close control to prevent users from being trapped in the ad. For
        /// outstream ads that do not interfere with content, the close control is not mandatory.
        ///
        /// It is also up to the publisher whether a skippable video should show an associated end-card when the video
        /// is skipped. Most implementations by major mobile SDKs currently do so.
        ///
        /// Click-throughs triggered from the companion should make sure to open in a new browser window rather than
        /// replacing the existing end card or another window needed by the app. This ensures that the consumer can exit
        /// the webpage that’s loaded upon clicking through the ad and to make sure that the app experience isn’t
        /// disrupted.
        ///
        /// The VAST event of closeLinear must be fired upon the companion closing. This allows for ads that use
        /// companions to know when the companion was dismissed.
        ///
        /// **Companion as Concurrent Display Ad**
        ///
        /// A value of "concurrent" signals to the player that this companion ad is meant to be shown alongside the
        /// video for the duration of the video playback. This reflects the original use of the companion in desktop
        /// inventory.
        ///
        /// **Additional Creative Uses of the Companion Ad**
        ///
        /// The companion ad may be used for new implementations, and as such new values of the renderingMode attribute
        /// may be used if supported by the publisher and the ad server. The renderingMode may use other values other
        /// than the ones listed to support these additional use cases.
        ///
        /// For example, proprietary formats that show content alongside a video could be supported by the standard with
        /// a “split-screen” renderingMode, displaying a 1:1 aspect ratio video, alongside an equal sized companion in
        /// both portrait and landscape mode.
        ///
        /// The goal is that renderingMode will provide some initial standards support for format innovation in
        /// environments that cannot, or will not, support VPAID with future spec changes to follow market developments.
        ///
        /// **Default or Empty renderingMode**
        ///
        /// The renderingMode attribute may be omitted. In this case, the player will assume that the renderingMode
        /// value is set as “default” and will handle the companion in whatever way it does by default.
        public let renderingMode: RenderingMode
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
        /// The AltText element is used to provide a description of the companion creative when an ad viewer mouses over
        /// the ad.
        public let altText: AltText?
        /// Most companion creative can provide a clickthrough of their own, but in the case where the creative cannot
        /// provide a clickthrough, such as with a simple static image, the CompanionClickThrough element can be used to
        /// provide the clickthrough.
        ///
        /// A clickthrough may need to be provided for an InLine ad in the following situations:
        ///   - Static image file
        ///   - Any static resource file where the media player handles the click, such as when “playerHandles=true” in
        ///     a VPAID AdClickThru event.
        public let companionClickThrough: CompanionClickThrough?
        /// The `<TrackingEvents>` element is available for `Linear`, `NonLinear`, and `Companion`, elements in both
        /// InLine and Wrapper formats. When the media player detects that a specified event occurs, the media player is
        /// required to trigger the tracking resource URI provided in the nested `<Tracking>` element. When the server
        /// receives this request, it records the event and the time it occurred.
        public let trackingEvents: TrackingEvents?
        /// An optional identifier for the creative.
        public let id: String?
        /// The pixel width of the creative.
        public let assetWidth: Int?
        /// The pixel height of the creative.
        public let assetHeight: Int?
        /// The maximum pixel width of the creative in its expanded state.
        public let expandedWidth: Int?
        /// The maximum pixel height of the creative in its expanded state.
        public let expandedHeight: Int?
        /// The API necessary to communicate with the creative if available.
        public let apiFramework: String?
        /// Used to identify desired placement on a publisher’s page. Values to be used should be discussed between
        /// publishers and advertisers.
        public let adSlotId: String?
        /// The pixel ratio for which the companion creative is intended. The pixel ratio is the ratio of physical
        /// pixels on the device to the device-independent pixels. An ad intended for display on a device with a pixel
        /// ratio that is twice that of a standard 1:1 pixel ratio would use the value "2." Default value is "1."
        public let pxratio: String?

        public init(
            width: Int,
            height: Int,
            staticResource: [StaticResource],
            iFrameResource: [IFrameResource],
            htmlResource: [HTMLResource],
            companionClickTracking: [CompanionClickTracking],
            renderingMode: RenderingMode = .default,
            adParameters: AdParameters?,
            altText: AltText?,
            companionClickThrough: CompanionClickThrough?,
            trackingEvents: TrackingEvents?,
            id: String?,
            assetWidth: Int?,
            assetHeight: Int?,
            expandedWidth: Int?,
            expandedHeight: Int?,
            apiFramework: String?,
            adSlotId: String?,
            pxratio: String?
        ) {
            self.width = width
            self.height = height
            self.staticResource = staticResource
            self.iFrameResource = iFrameResource
            self.htmlResource = htmlResource
            self.companionClickTracking = companionClickTracking
            self.renderingMode = renderingMode
            self.adParameters = adParameters
            self.altText = altText
            self.companionClickThrough = companionClickThrough
            self.trackingEvents = trackingEvents
            self.id = id
            self.assetWidth = assetWidth
            self.assetHeight = assetHeight
            self.expandedWidth = expandedWidth
            self.expandedHeight = expandedHeight
            self.apiFramework = apiFramework
            self.adSlotId = adSlotId
            self.pxratio = pxratio
        }
    }
}

public extension VAST.Element.Companion {
    enum RenderingMode: RawRepresentable {
        /// The renderingMode attribute may be omitted. In this case, the player will assume that the renderingMode
        /// value is set as “default” and will handle the companion in whatever way it does by default.
        case `default`
        /// A value of "end-card" signals to the player that this companion ad is meant to be shown after the video
        /// stops playing. The end-card should match the dimensions of the preceding video. If the companion width and
        /// height are not zero, the player may use these values to infer the aspect ratio of the companion ad.
        ///
        /// Companion duration is a new consideration for the end-card and assumed to be controlled by the publisher
        /// player/SDK and communicated as part of the publisher ad format specs. Known variations in market include an
        /// “infinite” duration, which requires the viewer to close the end-card after it is shown, and a timed
        /// duration. For any companion that suspends content playback, such as an in-stream ad, and does not include a
        /// time-out, the player/SDK must implement a close control to prevent users from being trapped in the ad. For
        /// outstream ads that do not interfere with content, the close control is not mandatory.
        ///
        /// It is also up to the publisher whether a skippable video should show an associated end-card when the video
        /// is skipped. Most implementations by major mobile SDKs currently do so.
        ///
        /// Click-throughs triggered from the companion should make sure to open in a new browser window rather than
        /// replacing the existing end card or another window needed by the app. This ensures that the consumer can exit
        /// the webpage that’s loaded upon clicking through the ad and to make sure that the app experience isn’t
        /// disrupted.
        ///
        /// The VAST event of closeLinear must be fired upon the companion closing. This allows for ads that use
        /// companions to know when the companion was dismissed.
        case endCard
        /// A value of "concurrent" signals to the player that this companion ad is meant to be shown alongside the
        /// video for the duration of the video playback. This reflects the original use of the companion in desktop
        /// inventory.
        case concurrent
        /// The companion ad may be used for new implementations, and as such new values of the renderingMode attribute
        /// may be used if supported by the publisher and the ad server. The renderingMode may use other values other
        /// than the ones listed to support these additional use cases.
        ///
        /// For example, proprietary formats that show content alongside a video could be supported by the standard with
        /// a “split-screen” renderingMode, displaying a 1:1 aspect ratio video, alongside an equal sized companion in
        /// both portrait and landscape mode.
        ///
        /// The goal is that renderingMode will provide some initial standards support for format innovation in
        /// environments that cannot, or will not, support VPAID with future spec changes to follow market developments.
        case custom(String)

        public var rawValue: String {
            switch self {
            case .default: return "default"
            case .endCard: return "end-card"
            case .concurrent: return "concurrent"
            case .custom(let string): return string
            }
        }

        public init(rawValue: String) {
            switch rawValue {
            case "default": self = .default
            case "end-card": self = .endCard
            case "concurrent": self = .concurrent
            default: self = .custom(rawValue)
            }
        }
    }
}
