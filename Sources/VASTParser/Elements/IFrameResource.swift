import Foundation

public extension VAST.Element {
    /// A URI to the iframe creative file to be used for the ad component identified in the parent element.
    ///
    /// The URI to an HTML resource file to be loaded into an iframe by the publisher. Associated with the ad
    /// component identified in the parent element, which is either: `<NonLinear>`, `<Companion>`, or `<Icon>`.
    typealias IFrameResource = URL
}
