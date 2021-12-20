public extension VAST.Element {
    /// The ad serving party must provide a descriptive name for the system that serves the ad. Optionally,
    /// a version number for the ad system may also be provided using the version attribute.
    struct AdSystem: Equatable {
        /// A string that provides the name of the ad server that returned the ad
        public let content: String
        /// A string that provides the version number of the ad system that returned the ad
        public let version: String?

        public init(content: String, version: String?) {
            self.version = version
            self.content = content
        }
    }
}
