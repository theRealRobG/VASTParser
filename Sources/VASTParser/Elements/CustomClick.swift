import Foundation

public extension VAST.Element {
    /// The `<CustomClick>` is used to track any interactions with the linear ad that do not include the
    /// clickthrough click and do not take the viewer away from the media player. For example, if an ad vendor wants
    /// to track that a viewer clicked a button to change the ad's background color, the `<CustomClick>` element
    /// holds the URI to notify the ad vendor that this click happened. An API may be needed to inform the player
    /// that a click occurred and that the corresponding URI should be activated.
    struct CustomClick {
        /// A URI for tracking custo interactions.
        public let content: URL
        /// A unique ID for the custom click to be tracked.
        public let id: String?

        public init(content: URL, id: String?) {
            self.content = content
            self.id = id
        }
    }
}
