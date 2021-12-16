import Foundation

public extension VAST.Element {
    /// A container for the URI to the JavaScript file used to collect verification data.
    ///
    /// Some verification vendors may provide JavaScript executables which work in non-browser environments, for
    /// example, in an iOS app enabled by **JavaScriptCore**. These resources only require methods of the API
    /// framework, without relying on any browser built-in functionality.
    ///
    /// Players that execute verification code in a browser or webview context should prefer
    /// `browserOptional="false"` resources if both are available, but may also execute `browserOptional="true"`
    /// resources. Players that execute verification code in a non-browser environment (e.g. **JavaScriptCore**) may
    /// only execute resources marked `browserOptional="true"`. If only `browserOptional="false"` resources are
    /// provided, the player must trigger any provided `verificationNotExecuted` tracking events with reason code 2,
    /// to indicate the provided code is not supported.
    struct JavaScriptResource {
        /// A CDATA-wrapped URI to the JavaScript used to collect data
        public let content: URL
        /// The name of the API framework used to execute the AdVerification code
        public let apiFramework: String
        /// Boolean value. If `true`, this resource is optimized and able to execute in an environment without DOM and
        /// other browser built-ins (e.g. iOS' **JavaScriptCore**).
        public let browserOptional: Bool?

        init(content: URL, apiFramework: String, browserOptional: Bool?) {
            self.content = content
            self.apiFramework = apiFramework
            self.browserOptional = browserOptional
        }
    }
}
