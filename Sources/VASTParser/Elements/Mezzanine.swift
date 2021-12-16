import Foundation

public extension VAST.Element {
    /// The media player may use a raw mezzanine file to transcode video or audio files at quality levels specific
    /// to the needs of certain environments. An XSD will validate this element as optional, but a mezzanine file is
    /// required in ad-stitched executions and whenever a publisher requires it. If no mezzanine file is available,
    /// this element may be excluded; however, publishers that require it may ignore the VAST response when not
    /// provided. If an ad is rejected for this reason, error code 406 is available to communicate the error when an
    /// `<Error>` URI and macro are provided.
    ///
    /// Publishers consume mezzanine files to transcode the media into a form publisher’s system and user devices
    /// support. The mezzanine file should never be used for the direct ad playback.
    struct Mezzanine {
        /// A CDATA-wrapped URI to a media file.
        public let content: URL
        /// Either “progressive” for progressive download protocols (such as HTTP) or “streaming” for streaming
        /// protocols.
        public let delivery: MediaFile.Delivery
        /// MIME type for the file container. Popular MIME types include, but are not limited to “video/mp4” for MP4,
        /// “audio/mpeg” and "audio/aac" for audio ads.
        public let type: String
        /// The native width of the video file, in pixels. (0 for audio ads)
        public let width: Int
        /// The native height of the video file, in pixels. (0 for audio ads)
        public let height: Int
        /// Type of media file (2D / 3D / 360 / etc).
        ///
        /// Default value = 2D
        public let mediaType: String
        /// The codec used to encode the file which can take values as specified by RFC 4281:
        /// http://tools.ietf.org/html/rfc4281.
        public let codec: String?
        /// An identifier for the media file.
        public let id: String?
        /// Optional field that helps eliminate the need to calculate the size based on bitrate and duration.
        ///
        /// Units - Bytes
        public let fileSize: Int?

        public init(
            content: URL,
            delivery: MediaFile.Delivery,
            type: String,
            width: Int?,
            height: Int?,
            mediaType: String?,
            codec: String?,
            id: String?,
            fileSize: Int?
        ) {
            self.content = content
            self.delivery = delivery
            self.type = type
            self.width = width ?? 0
            self.height = height ?? 0
            self.mediaType = mediaType ?? "2D"
            self.codec = codec
            self.id = id
            self.fileSize = fileSize
        }
    }
}
