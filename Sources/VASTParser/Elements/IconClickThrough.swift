import Foundation

public extension VAST.Element {
    /// The `<IconClickThrough>` is used to provide a URI to the industry program page that the media player opens
    /// when the icon is clicked.
    struct IconClickThrough {
        /// A URI to the industry program page opened when a viewer clicks the icon.
        public let content: URL

        public init(content: URL) {
            self.content = content
        }
    }
}
