import Foundation

public extension VAST.Element {
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
    struct MediaFile {
        /// A CDATA-wrapped URI to a media file.
        public let content: URL
        /// Either “progressive” for progressive download protocols (such as HTTP) or “streaming” for streaming
        /// protocols.
        public let delivery: Delivery
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
        /// For progressive load video or audio, the `bitrate` value specifies the average bitrate for the media file;
        /// otherwise the `minBitrate` and `maxBitrate` can be used together to specify the minimum and maximum bitrates
        /// for streaming videos or audio files.
        public let bitrateDescription: BitrateDescription?
        /// A Boolean value that indicates whether the media file is meant to scale to larger dimensions.
        public let scalable: Bool?
        /// A Boolean value that indicates whether aspect ratio for media file dimensions should be maintained when
        /// scaled to new dimensions.
        public let maintainAspectRatio: Bool?
        /// Identifies the API needed to execute an interactive media file, but current support is for backward
        /// compatibility. Please use the `<InteractiveCreativeFile>` element to include files that require an API for
        /// execution.
        public let apiFramework: String?
        /// Optional field that helps eliminate the need to calculate the size based on bitrate and duration.
        ///
        /// Units - Bytes
        public let fileSize: Int?

        public init(
            content: URL,
            delivery: Delivery,
            type: String,
            width: Int?,
            height: Int?,
            mediaType: String?,
            codec: String?,
            id: String?,
            bitrateDescription: BitrateDescription?,
            scalable: Bool?,
            maintainAspectRatio: Bool?,
            apiFramework: String?,
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
            self.bitrateDescription = bitrateDescription
            self.scalable = scalable
            self.maintainAspectRatio = maintainAspectRatio
            self.apiFramework = apiFramework
            self.fileSize = fileSize
        }
    }
}

public extension VAST.Element.MediaFile {
    enum Delivery: String {
        case progressive
        case streaming
    }

    struct MinMaxBitrate {
        public let minBitrate: Int
        public let maxBitrate: Int

        public init(minBitrate: Int, maxBitrate: Int) {
            self.minBitrate = minBitrate
            self.maxBitrate = maxBitrate
        }
    }

    enum BitrateDescription {
        case bitrate(Int)
        case minMaxBitrate(MinMaxBitrate)

        public init(bitrate: Int) {
            self = .bitrate(bitrate)
        }

        public init(minBitrate: Int, maxBitrate: Int) {
            self = .minMaxBitrate(MinMaxBitrate(minBitrate: minBitrate, maxBitrate: maxBitrate))
        }
    }
}
