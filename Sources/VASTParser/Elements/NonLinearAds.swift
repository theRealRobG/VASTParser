public extension VAST.Element {
    /// NonLinear ads are the overlay ads that display as an image or rich media on top of video content during
    /// playback. Within an InLine ad, at least one of `<Linear>` or `<NonLinearAds>` needs to be provided within
    /// the `<Creative>` element.
    ///
    /// NonLinearAds are not applicable to Audio use cases.
    ///
    /// The `<NonLinearAds>` element is a container for the `<NonLinear>` creative files and tracking resources. If
    /// used in a wrapper, only the tracking elements are available. NonLinear creative cannot be provided in a
    struct NonLinearAds {
        /// Each `<NonLinear>` element may provide different versions of the same creative using the `<StaticResource>`,
        /// `<IFrameResource>`, and `<HTMLResource>` elements in the InLine VAST response. In a Wrapper response, only
        /// tracking elements may be provided.
        public let nonLinear: [NonLinear]
        /// The `<TrackingEvents>` element is available for `Linear`, `NonLinear`, and `Companion`, elements in both
        /// InLine and Wrapper formats. When the media player detects that a specified event occurs, the media player is
        /// required to trigger the tracking resource URI provided in the nested `<Tracking>` element. When the server
        /// receives this request, it records the event and the time it occurred.
        public let trackingEvents: TrackingEvents?

        public init(nonLinear: [NonLinear], trackingEvents: TrackingEvents?) {
            self.nonLinear = nonLinear
            self.trackingEvents = trackingEvents
        }
    }
}
