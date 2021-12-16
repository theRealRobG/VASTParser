import Foundation

public extension VAST.Element {
    /// When the companion ad creative handles the clickthrough in an InLine ad, the CompanionClickTracking element
    /// is used to track the click, provided the ad has a way to notify the player that that ad was clicked, such as
    /// when using a VPAID ad unit. The CompanionClickTracking element is also used in Wrappers to track clicks that
    /// occur for the Companion creative in the InLine ad that is returned after one or more wrappers.
    ///
    /// CompanionClickTracking might be used for an InLine ad when:
    ///   - Any static resource file where the media player handles the click, such as when “playerHandles=true” in
    ///     a VPAID AdClickThru event
    ///
    /// CompanionClickTracking is used in a Wrapper in the following situations:
    ///   - Static image file. Any static resource file where the media player handles the click, such as when
    ///     “playerHandlesClick=true” in VPAID
    ///   - Any static resource file where the media player handles the click, such as when
    ///     “playerHandlesClick=true” in VPAID
    struct CompanionClickTracking {
        /// A URI to a tracking resource file used to track a companion clickthrough
        public let content: URL
        /// An id provided by the ad server to track the click in reports.
        public let id: String?

        public init(content: URL, id: String?) {
            self.content = content
            self.id = id
        }
    }
}
