public extension VAST.Element {
    /// A required element for the purpose of tracking ad creative, the `<UniversalAdId>` is used
    /// to provide a unique creative identifier that is maintained across systems. This creative ID may
    /// be generated with an authoritative program, such as the AD-ID® program in the United States,
    /// or Clearcast in the UK. Some countries may have specific requirements for ad- tracking
    /// programs.
    ///
    /// Note: A creative id can also be included in the adId attribute used in the `<Creative>`
    /// element, but that creative id should be used to specify the ad server’s unique identifier.
    /// The UniversalAdId is used for maintaining a creative id for the ad across multiple systems.
    ///
    /// Examples:
    /// ```
    ///  <UniversalAdId idRegistry="ad-id.org">CNPA0484000H<UniversalAdId>
    ///  <UniversalAdId idRegistry="clearcast.co.uk"> AAA/BBBB123/030<UniversalAdId>
    /// ```
    struct UniversalAdId {
        /// A string identifying the unique creative identifier. Default value is “unknown”
        public let content: String
        /// A string used to identify the URL for the registry website where the unique creative ID is cataloged.
        /// Default value is “unknown.”
        public let idRegistry: String

        public init(content: String = "unknown", idRegistry: String = "unknown") {
            self.content = content
            self.idRegistry = idRegistry
        }
    }
}
