public extension VAST.Element {
    /// Providing an advertiser name can help publishers prevent display of the ad with its competitors. Ad
    /// serving parties and publishers should identify how to interpret values provided within this element.
    struct Advertiser: Equatable {
        /// An (optional) identifier for the advertiser, provided by the ad server. Can be used for internal
        /// analytics.
        public let id: String?
        /// A string that provides the name of the advertiser as defined by the ad serving party.
        /// Recommend using the domain of the advertiser.
        public let content: String

        public init(id: String?, content: String) {
            self.id = id
            self.content = content
        }
    }
}
