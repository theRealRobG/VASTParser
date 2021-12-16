public extension VAST.Element {
    /// Any ad server that returns a VAST containing an `<InLine>` ad must generate a pseudo-
    /// unique identifier that is appropriate for all involved parties to track the lifecycle of that ad.
    /// This should be inserted into the `<AdServingId>` element, and also be included on all
    /// outgoing tracking pixels. The purpose of this id is to greatly reduce the amount of work
    /// required to compare impression-level data across multiple systems, which is otherwise done
    /// by passing proprietary IDs across different systems and matching them.
    struct AdServingId {
        /// A unique or pseudo-unique (long enough to be unique when combined with timestamp data)
        /// GUID .
        public let content: String

        public init(content: String) {
            self.content = content
        }
    }
}
