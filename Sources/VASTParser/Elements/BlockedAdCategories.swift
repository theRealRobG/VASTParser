import Foundation

public extension VAST.Element {
    /// Ad categories are used in creative separation and for compliance in certain programs. In a wrapper, this
    /// field defines ad categories that cannot be returned by a downstream ad server. This value is used to
    /// populate the `[BLOCKEDADCATEGORIES]` request macro in VASTAdTagURI strings, and can also be used by the
    /// player to reject InLine ads with Category fields that violate the BlockedAdCategories fields of upstream
    /// wrappers. If an InLine ad is skipped due to a category violation, the client must notify the ad server using
    /// the `<Error>` URI, if provided (error code 205), and move on to the next option.
    struct BlockedAdCategories {
        /// A string that provides a comma separated list of category codes or labels per authority that identify the ad
        /// content.
        public let content: String
        /// A URL for the organizational authority that produced the list being used to identify ad content.
        public let authority: URL?

        public init(content: String, authority: URL?) {
            self.content = content
            self.authority = authority
        }
    }
}
