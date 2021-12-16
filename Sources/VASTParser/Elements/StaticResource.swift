import Foundation

public extension VAST.Element {
    /// The URI to a static creative file to be used for the ad component identified in the parent element, which is
    /// either: `<NonLinear>`, `<Companion>`, or `<Icon>`.
    struct StaticResource {
        /// A URI to the static creative file to be used for the ad component identified in the parent element.
        public let content: URL
        /// Identifies the MIME type of the creative provided.
        public let creativeType: String

        public init(content: URL, creativeType: String) {
            self.content = content
            self.creativeType = creativeType
        }
    }
}
