import Foundation

public extension VAST.Element {
    /// The `<ViewUndetermined>` element is a container for placing a URI that the player triggers if
    /// it cannot determine whether the ad has met criteria for a viewable video ad impression.
    struct ViewUndetermined {
        /// A URI that directs the media player to a tracking resource file that the media player should
        /// request if the player cannot determine whether criteria is met for a viewable impression.
        public let content: URL

        public init(content: URL) {
            self.content = content
        }
    }
}
