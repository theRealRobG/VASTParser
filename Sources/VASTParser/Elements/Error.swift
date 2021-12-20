import Foundation

public extension VAST.Element {
    /// A URI supplied by the ad server and used to report the no ad response.
    ///
    /// The `<Error>` element contains a URI that the player uses to notify the ad server when errors occur with ad
    /// playback. If the URI contains an `[ERRORCODE]` macro, the media player must populate the macro with an error
    /// code as defined in section 2.3.6 of VAST 4.2.
    ///
    /// If no specific error can be found, error 900 may be used to indicate an undefined error; however, every attempt
    /// should be made to provide an error code that maps to the error that occurred. The `<Error>` element is available
    /// for both the InLine or Wrapper elements.
    typealias Error = URL
}
