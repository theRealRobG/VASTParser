import Foundation

public extension VAST.Element {
    /// While VAST Wrappers don’t provide all the same elements offered for an InLine ad, the `<VASTAdTagURI>` is
    /// the only element that is unique to Wrappers. The VASTAdTagURI is used to provide a URI to a secondary VAST
    /// response. This secondary response may be another Wrapper, but eventually a VAST wrapper must return an
    /// `<InLine>` ad. In VAST 4 the player is only required to accept five wrappers ads. If no InLine ads are
    /// returned after 5 Wrappers, the player may move on to the next option.
    struct VASTAdTagURI {
        /// A URI to a VAST response that may be another VAST Wrapper or a VAST InLine ad. The number of VAST wrappers
        /// should not exceed 5 before an InLine ad is served. After 5 VAST wrapper responses, acceptance of additional
        /// VAST responses is at the publisher’s discretion.
        public let content: URL

        public init(content: URL) {
            self.content = content
        }
    }
}
