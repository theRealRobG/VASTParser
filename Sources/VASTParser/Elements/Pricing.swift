public extension VAST.Element {
    /// Used to provide a value that represents a price that can be used by real-time bidding (RTB)
    /// systems. VAST is not designed to handle RTB since other methods exist, but this element is offered
    /// for custom solutions if needed. If the value provided is to be obfuscated or encoded, publishers and
    /// advertisers must negotiate the appropriate mechanism to do so.
    /// When included as part of a VAST Wrapper in a chain of Wrappers, only the value offered in the first
    /// Wrapper need be considered.
    struct Pricing {
        /// Identifies the pricing model as one of: CPM, CPC, CPE, or CPV.
        public let model: Model
        /// The three-letter ISO-4217 currency symbol that identifies the currency of the value provided
        /// (e.g. USD, GBP, etc.).
        public let currency: String
        /// A number that represents a price that can be used in real-time bidding systems
        public let content: Double

        public init(
            model: Model,
            currency: String,
            content: Double
        ) {
            self.model = model
            self.currency = currency
            self.content = content
        }
    }
}

public extension VAST.Element.Pricing {
    enum Model: String {
        case cpm = "CPM"
        case cpc = "CPC"
        case cpe = "CPE"
        case cpv = "CPV"
    }
}
