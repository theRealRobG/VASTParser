public extension VAST.Element {
    /// Individual closed caption files for various languages.
    ///
    /// Optional node that enables closed caption sidecar files associated with the ad media (video or audio) to be
    /// provided to the player. Multiple files with different mime-types may be provided as children of this node to
    /// allow the player to select the one it is compatible with.
    ///
    /// **Note:** It is expected that all the media files tied to parent MediaFiles node are associated with the
    /// same original creative and therefore of the same media length as well as accurately synchronized with closed
    /// captioned media segments times, so all the files under ClosedCaptionFiles should work for all the MediaFile
    /// nodes.
    typealias ClosedCaptionFiles = [ClosedCaptionFile]
}
