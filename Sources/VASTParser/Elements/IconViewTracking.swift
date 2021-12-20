import Foundation

public extension VAST.Element {
    /// A URI for the tracking resource file to be called when the icon creative is displayed.
    ///
    /// The view tracking for icons is used to track when the icon creative is displayed. The player uses the
    /// included URI to notify the icon server when the icon has been displayed.
    typealias IconViewTracking = URL
}
