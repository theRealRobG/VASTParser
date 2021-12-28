import Foundation

public extension VAST.Element {
    /// The ad server provides an impression-tracking URI for either the InLine ad or the Wrapper
    /// using the `<Impression>` element. All `<Impression>` URIs in the InLine response and any
    /// Wrapper responses preceding it should be triggered at the same time when the impression
    /// for the ad occurs, or as close in time as possible to when the impression occurs, to prevent
    /// impression-counting discrepancies.
    struct Impression: Equatable {
        /// An ad server id for the impression. Impression URIs of the same id for an ad should be
        /// requested at the same time or as close in time as possible to help prevent discrepancies.
        public let id: String?
        /// A URI that directs the media player to a tracking resource file that the media player must use
        /// to notify the ad server when the impression occurs. If there is no reason to include an
        /// Impression element, the placeholder "about:blank" should be used instead of a tracking URL.
        /// The player should disregard dispatching the tracking URI if it is set to "about:blank".
        public let content: Content

        public init(id: String?, content: Content) {
            self.id = id
            self.content = content
        }
    }
}

public extension VAST.Element.Impression {
    enum Content: Equatable {
        case url(URL)
        case blank

        public init?(_ content: String) {
            if content == "about:blank" {
                self = .blank
            } else if let url = URL(string: content) {
                self = .url(url)
            } else {
                return nil
            }
        }
    }
}
