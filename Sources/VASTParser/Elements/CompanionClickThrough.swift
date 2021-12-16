import Foundation

public extension VAST.Element {
    /// Most companion creative can provide a clickthrough of their own, but in the case where the creative cannot
    /// provide a clickthrough, such as with a simple static image, the CompanionClickThrough element can be used to
    /// provide the clickthrough.
    ///
    /// A clickthrough may need to be provided for an InLine ad in the following situations:
    ///   - Static image file
    ///   - Any static resource file where the media player handles the click, such as when “playerHandles=true” in
    ///     a VPAID AdClickThru event.
    struct CompanionClickThrough {
        /// A URI to the advertiser’s page that the media player opens when the viewer clicks the companion ad.
        public let content: URL

        public init(content: URL) {
            self.content = content
        }
    }
}
