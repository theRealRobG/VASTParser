import Foundation

public extension VAST.Element {
    /// Multiple `<ClickTracking>` elements can be used in the case where multiple parties would like to track the
    /// Linear ad clickthrough.
    struct ClickTracking {
        /// A URI for tracking when the ClickThrough is triggered.
        public let content: URL
        /// A unique ID for the click to be tracked.
        public let id: String?

        public init(content: URL, id: String?) {
            self.content = content
            self.id = id
        }
    }
}
