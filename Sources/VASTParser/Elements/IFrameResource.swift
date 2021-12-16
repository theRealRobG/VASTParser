import Foundation

public extension VAST.Element {
    /// The URI to an HTML resource file to be loaded into an iframe by the publisher. Associated with the ad
    /// component identified in the parent element, which is either: `<NonLinear>`, `<Companion>`, or `<Icon>`.
    struct IFrameResource {
        /// A URI to the iframe creative file to be used for the ad component identified in the parent element.
        public let content: URL

        public init(content: URL) {
            self.content = content
        }
    }
}
