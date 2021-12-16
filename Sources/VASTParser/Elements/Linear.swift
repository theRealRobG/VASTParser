public extension VAST.Element {
    /// Linear Ads are the video or audio formatted ads that play linearly within the streaming content,
    /// meaning before the streaming content, during a break, or after the streaming content. A Linear
    /// creative contains a `<Duration>` element to communicate the intended runtime and a
    /// `<MediaFiles>` element used to provide the needed video or audio files for ad execution.
    struct Linear {
        /// The ad server uses the `<Duration>` element to denote the intended playback duration for the video or audio
        /// component of the ad. Time value may be in the format HH:MM:SS.mmm where .mmm indicates milliseconds.
        /// Providing milliseconds is optional.
        public let duration: Duration
        /// Since the first version of VAST, the MediaFiles element was designated for linear video files. Over the
        /// years as digital video technology advanced, the media files placed in a VAST tag have come to include
        /// complex files that require API integration. Players not equipped with the technology to execute such files
        /// may be unable to play the ad or execute interactive components. In ads that require API integration, VAST 4
        /// separates media and interactive files. While `<MediaFiles>` node focus shifts to the exclusive delivery of
        /// media (video and audio), the dedicated `<InteractiveCreativeFile>` element opens opportunities for rendering
        /// modern secure interactive components in parallel with video and audio assets. The dedicated `<Verification>`
        /// element allows for measurement capabilities. Disjoining media and executable files enables a wider range of
        /// players to consume enhanced ads as well as performance improvements.
        ///
        /// It is worth noting that when multiple MediaFile nodes are present, the publisher should decide which file to
        /// play based on attributes of the MediaFile nodes and not the structure of the document (e.g. defaulting to
        /// the first MediaFile included in the document).
        ///
        /// Linear media files should be submitted as follows:
        ///   - **Video/Audio file only:** Include three `<MediaFile>` elements, each with a URI to a ready-to-serve
        ///     video or audio file at quality levels for high, medium, and low. Please review the IAB Digital Video Ad
        ///     Format Guidelines for guidance on ready-to-serve file quality specifications.
        ///   - **Video/Audio file for use in ad-stitching:** In addition to the three ready-to-serve files, use the
        ///     `<Mezzanine>` element to include a URI to the raw video or audio file. Please review the IAB Digital
        ///     Video Ad Format Guidelines for guidance on mezzanine file specifications.
        ///   - **Interactive linear video file:** In addition to at least one ready-to-serve video/audio file included in
        ///     the `<MediaFile>` element, use the `<InteractiveCreativeFile>` element to include a URI to the
        ///     interactive media file, specifying the API framework required to execute the file.
        public let mediaFiles: MediaFiles
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
        /// The `<TrackingEvents>` element is available for `Linear`, `NonLinear`, and `Companion`, elements in both
        /// InLine and Wrapper formats. When the media player detects that a specified event occurs, the media player is
        /// required to trigger the tracking resource URI provided in the nested `<Tracking>` element. When the server
        /// receives this request, it records the event and the time it occurred.
        public let trackingEvents: TrackingEvents?
        /// The `<VideoClicks>` element provides URIs for `clickthroughs`, `clicktracking`, and `custom` clicks and is
        /// available for Linear Ads in both the InLine and Wrapper formats. Both InLine and Wrapper formats offer the
        /// ClickThrough, ClickTracking and CustomClick elements. These elements are defined in the following sections.
        public let videoClicks: VideoClicks?
        /// The industry icon feature was defined in VAST 3.0 to support initiatives such as privacy programs. An
        /// example of such a program is the AdChoices program for interest-based advertising (IBA). Though the VAST
        /// icon feature was initially created to support privacy programs, it was designed to support other programs
        /// that require posting an icon with the linear ad.
        ///
        /// This feature is only offered for Linear Ads because icons can be easily inserted in NonLinear ads and
        /// companion creative using existing features. Icon source files may also be included in a wrapper if
        /// necessary.
        public let icons: Icons?
        /// Time value that identifies when skip controls are made available to the end user; publisher may define a
        /// minimum `skipoffset` value in its policies and disregard Skippable creative when `skipoffset` values are
        /// lower than publisher's minimum.
        public let skipoffset: Double?

        public init(
            duration: Duration,
            mediaFiles: MediaFiles,
            adParameters: AdParameters?,
            trackingEvents: TrackingEvents?,
            videoClicks: VideoClicks?,
            icons: Icons?,
            skipoffset: Double?
        ) {
            self.duration = duration
            self.mediaFiles = mediaFiles
            self.adParameters = adParameters
            self.trackingEvents = trackingEvents
            self.videoClicks = videoClicks
            self.icons = icons
            self.skipoffset = skipoffset
        }
    }
}
