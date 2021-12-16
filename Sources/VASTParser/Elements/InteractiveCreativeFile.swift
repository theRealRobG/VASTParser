import Foundation

public extension VAST.Element {
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
    struct InteractiveCreativeFile {
        /// A CDATA-wrapped URI to a file providing creative functions for the media file.
        public let content: URL
        /// Identifies the MIME type of the file provided.
        public let type: String?
        /// Identifies the API needed to execute the resource file if applicable.
        public let apiFramework: String?
        /// Useful for interactive use cases. Identifies whether the ad always drops when the duration is reached, or if
        /// it can potentially extend the duration by pausing the underlying video or delaying the adStopped call after
        /// adVideoComplete. If set to `true`, the extension of the duration should be user-initiated (typically, by
        /// engaging with an interactive element to view additional content).
        public let variableDuration: Bool?

        public init(
            content: URL,
            type: String?,
            apiFramework: String?,
            variableDuration: Bool?
        ) {
            self.content = content
            self.type = type
            self.apiFramework = apiFramework
            self.variableDuration = variableDuration
        }
    }
}
