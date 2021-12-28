import Foundation

public extension VAST.Element {
    /// Individual closed caption files for various languages.
    struct ClosedCaptionFile: Equatable {
        /// A CDATA-wrapped URI to a file providing Closed Caption info for the media file.
        public let content: URL
        /// Identifies the MIME type of the file provided.
        public let type: String?
        /// Language of the Closed Caption File using ISO 631-1 codes. An optional locale suffix can also be provided.
        ///
        /// Example:- “en”, “en-US”, “zh-TW”.
        public let language: String?

        public init(
            content: URL,
            type: String?,
            language: String?
        ) {
            self.content = content
            self.type = type
            self.language = language
        }
    }
}
