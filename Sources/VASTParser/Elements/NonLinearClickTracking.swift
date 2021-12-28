import Foundation

public extension VAST.Element {
    /// When the NonLinear ad creative handles the clickthrough in an InLine ad, the `<NonLinearClickTracking>`
    /// element is used to track the click, provided the ad has a way to notify the player that that ad was clicked,
    /// such as when using a VPAID ad unit. The NonLinearClickTracking element is also used to track clicks in
    /// Wrappers.
    ///
    /// NonLinearClickTracking might be used for an InLine ad when:
    ///   - Any static resource file where the media player handles the click, such as when “playerHandles=true” in
    ///     a VPAID AdClickThru event.
    ///
    /// NonLinearClickTracking is used in a Wrapper Ad in the following situations:
    ///   - Static image file
    ///   - Flash file with no API framework (deprecated)
    ///   - Flash file in which apiFramework=clickTAG (deprecated)
    ///   - Any static resource file where the media player handles the click, such as when “playerHandles=true” in
    ///     a VPAID AdClickThru event
    struct NonLinearClickTracking {
        /// A URI to a tracking resource file used to track a NonLinear clickthrough
        public let content: URL
        /// An id provided by the ad server to track the click in reports.
        public let id: String?

        public init(content: URL, id: String?) {
            self.content = content
            self.id = id
        }
    }
}
