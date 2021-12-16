import Foundation

public extension VAST.Element {
    /// The `<NotViewable>` element is a container for placing a URI that the player triggers if the ad
    /// is executed but never meets criteria for a viewable video ad impression.
    struct NotViewable {
        /// A URI that directs the media player to a tracking resource file that the media player should
        /// request if the ad is executed but never meets criteria for a viewable impression.
        public let content: URL

        public init(content: URL) {
            self.content = content
        }
    }
}
