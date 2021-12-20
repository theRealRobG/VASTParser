public extension VAST.Element {
    /// A time value for the duration of the Linear ad in the format HH:MM:SS.mmm (.mmm is optional and indicates
    /// milliseconds).
    ///
    /// The ad server uses the `<Duration>` element to denote the intended playback duration for the video or audio
    /// component of the ad. Time value may be in the format HH:MM:SS.mmm where .mmm indicates milliseconds.
    /// Providing milliseconds is optional.
    typealias Duration = DurationString
}
