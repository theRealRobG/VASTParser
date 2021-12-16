import Foundation

public extension VAST.Element {
    /// Used in creative separation and for compliance in certain programs, a category field is
    /// needed to categorize the ad’s content. Several category lists exist, some for describing site
    /// content and some for describing ad content. Some lists are used interchangeably for both
    /// site content and ad content. For example, the category list used to comply with the IAB
    /// Quality Assurance Guidelines (QAG) describes site content, but is sometimes used to describe
    /// ad content.
    struct Category {
        /// A URL for the organizational authority that produced the list being used to identify ad content
        /// category.
        public let authority: URL?
        /// A string that provides a category code or label that identifies the ad content category.
        public let content: String

        public init(authority: URL?, content: String) {
            self.authority = authority
            self.content = content
        }
    }
}
