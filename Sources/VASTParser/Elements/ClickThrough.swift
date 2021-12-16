import Foundation

public extension VAST.Element {
    /// The `<ClickThrough>` is a URI to the advertiser’s site that the media player opens when a viewer clicks the
    /// ad. The clickthrough is available in the InLine and Wrapper formats and is used when the Linear ad unit
    /// cannot handle a clickthrough.
    struct ClickThrough {
        /// A URI to the advertiser’s site that the media player opens when a viewer clicks the ad.
        public let content: URL
        /// A unique ID for the clickthrough.
        public let id: String?

        public init(content: URL, id: String?) {
            self.content = content
            self.id = id
        }
    }
}
