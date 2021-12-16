import Foundation

public extension VAST.Element {
    /// The view tracking for icons is used to track when the icon creative is displayed. The player uses the
    /// included URI to notify the icon server when the icon has been displayed.
    struct IconViewTracking {
        /// A URI for the tracking resource file to be called when the icon creative is displayed.
        public let content: URL

        public init(content: URL) {
            self.content = content
        }
    }
}
