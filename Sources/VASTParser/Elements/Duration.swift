public extension VAST.Element {
    /// The ad server uses the `<Duration>` element to denote the intended playback duration for the video or audio
    /// component of the ad. Time value may be in the format HH:MM:SS.mmm where .mmm indicates milliseconds.
    /// Providing milliseconds is optional.
    struct Duration {
        /// A time value for the duration of the Linear ad in the format HH:MM:SS.mmm (.mmm is optional and indicates
        /// milliseconds).
        public let content: DurationString

        public init(content: String) {
            self.content = DurationString(stringLiteral: content)
        }
    }
}
