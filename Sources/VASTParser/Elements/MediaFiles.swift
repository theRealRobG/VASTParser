public extension VAST.Element {
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
    struct MediaFiles {
        /// In VAST 4.x `<MediaFile>` should only be used to contain the video or audio file for a Linear ad. In
        /// particular, three ready-to-serve files should be included, each of a quality level for high, medium, or low.
        /// A ready-to-serve video/audio file is a media that is transcoded to a level of quality that can be
        /// transferred over an internet connection within a reasonable time for viewing. Each ready-to-serve file must
        /// be of the same MIME type and, if different MIME types files are made available for the ad, three
        /// ready-to-serve files should represent each MIME type separately.
        ///
        /// When an interactive API is needed to deliver and execute the Linear Ad, the URI to the interactive file
        /// should be included in the `<InteractiveCreativeFile>`. In addition, at least one ready-to-serve video ad
        /// should be available in `<MediaFile>` so that the video ad can be played by the video player.
        ///
        /// Guidelines for ad files that fulfill quality levels of high, medium, or low can be found in the IAB Digital
        /// Video Ad Format Guidelines. An adaptive bitrate streaming file featuring files at the three quality levels
        /// may also be provided.
        public let mediaFile: MediaFile
        /// The media player may use a raw mezzanine file to transcode video or audio files at quality levels specific
        /// to the needs of certain environments. An XSD will validate this element as optional, but a mezzanine file is
        /// required in ad-stitched executions and whenever a publisher requires it. If no mezzanine file is available,
        /// this element may be excluded; however, publishers that require it may ignore the VAST response when not
        /// provided. If an ad is rejected for this reason, error code 406 is available to communicate the error when an
        /// `<Error>` URI and macro are provided.
        ///
        /// Publishers consume mezzanine files to transcode the media into a form publisher’s system and user devices
        /// support. The mezzanine file should never be used for the direct ad playback.
        public let mezzanine: Mezzanine?
        /// For any media file that uses interactive APIs for advanced creative functionality, the
        /// `<InteractiveCreativeFile>` element is used to identify the file and the framework needed for execution.
        ///
        /// Providing the interactive portion for a media file in a section of VAST separate from the video/audio file
        /// enables players to more easily play the video/audio file when no support is available to execute the API,
        /// especially for players that work with an ad-stitching service or make ad calls from a server on behalf of
        /// the player.
        ///
        /// The player should attempt to execute the interactive file before attempting to load any `<MediaFile>`, but
        /// if the file cannot be executed, the player should trigger any included error URIs and use error code 409
        /// when macros are provided.
        public let interactiveCreativeFile: InteractiveCreativeFile?
        /// Optional node that enables closed caption sidecar files associated with the ad media (video or audio) to be
        /// provided to the player. Multiple files with different mime-types may be provided as children of this node to
        /// allow the player to select the one it is compatible with.
        ///
        /// **Note:** It is expected that all the media files tied to parent MediaFiles node are associated with the
        /// same original creative and therefore of the same media length as well as accurately synchronized with closed
        /// captioned media segments times, so all the files under ClosedCaptionFiles should work for all the MediaFile
        /// nodes.
        public let closedCaptionFiles: ClosedCaptionFiles?

        public init(
            mediaFile: MediaFile,
            mezzanine: Mezzanine?,
            interactiveCreativeFile: InteractiveCreativeFile?,
            closedCaptionFiles: ClosedCaptionFiles?
        ) {
            self.mediaFile = mediaFile
            self.mezzanine = mezzanine
            self.interactiveCreativeFile = interactiveCreativeFile
            self.closedCaptionFiles = closedCaptionFiles
        }
    }
}
