import Foundation

public extension VAST.Element {
    /// `<IconClickTracking>` is used to track click activity within the icon.
    struct IconClickTracking {
        /// A URI to the tracking resource file to be called when a click corresponding to the `id` attribute (if
        /// provided) occurs.
        public let content: URL
        /// An id for the click to be measured.
        public let id: String?

        public init(content: URL, id: String?) {
            self.content = content
            self.id = id
        }
    }
}
