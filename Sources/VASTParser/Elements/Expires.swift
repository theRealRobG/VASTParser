public extension VAST.Element {
    /// The number of seconds in which the ad is valid for execution. In cases where the ad is requested
    /// ahead of time, this timing indicates how many seconds after the request that the ad expires and
    /// cannot be played. This element is useful for preventing an ad from playing after a timeout has
    /// occurred.
    ///
    /// If no value is provided, the response can be played back at any time indefinitely after being received
    /// by the player.
    struct Expires {
        /// An integer value that defines the expiry period (in seconds).
        public let content: Int

        public init(content: Int) {
            self.content = content
        }
    }
}
