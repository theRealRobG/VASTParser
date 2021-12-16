import Foundation

public extension VAST.Element {
    /// The survey node is deprecated in VAST 4.1, since usage was very limited and survey
    /// implementations can be supported by other VAST elements such as 3rd party trackers.
    ///
    /// Ad tech vendors may want to use the ad to collect data for resource purposes. The `<Survey>`
    /// element can be used to provide a URI to any resource file having to do with collecting survey data.
    /// Publishers and any parties using the `<Survey>` element should determine how surveys are
    /// implemented and executed. Multiple survey elements may be provided.
    ///
    /// A type attribute is available to specify the MIME type being served. For example, the attribute might
    /// be set to `type="text/javascript"`. Surveys can be dynamically inserted into the VAST
    /// response as long as cross-domain issues are avoided.
    struct Survey {
        /// The MIME type of the resource being served.
        public let type: String
        /// A URI to any resource relating to an integrated survey.
        public let content: URL

        public init(type: String, content: URL) {
            self.type = type
            self.content = content
        }
    }
}
