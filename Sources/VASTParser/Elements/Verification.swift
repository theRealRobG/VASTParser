import Foundation

public extension VAST.Element {
    /// The `<Verification>` element contains the executable and bootstrapping data required to run the measurement
    /// code for a single verification vendor. Multiple `<Verification>` elements may be listed, in order to support
    /// multiple vendors, or if multiple API frameworks are supported. At least one `<JavaScriptResource>` or
    /// `<ExecutableResource>` should be provided. At most one of these resources should selected for execution, as
    /// best matches the technology available in the current environment.
    ///
    /// If the player is willing and able to run one of these resources, it should execute them BEFORE creative
    /// playback begins. Otherwise, if no resource can be executed, any appropriate tracking events listed under the
    /// `<Verification>` element must be fired.
    struct Verification {
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
        public let javaScriptResource: [JavaScriptResource]
        /// A reference to a non-JavaScript or custom-integration resource intended for collecting verification data via
        /// the listed apiFramework.
        public let executableResource: [ExecutableResource]
        /// The verification vendor may provide URIs for tracking events relating to the execution of their code during
        /// the ad session.
        public let trackingEvents: TrackingEvents?
        /// CDATA-wrapped metadata string for the verification executable.
        ///
        /// `<VerificationParameters>` contains a CDATA-wrapped string intended for bootstrapping the verification code
        /// and providing metadata about the current impression. The format of the string is up to the individual vendor
        /// and should be passed along verbatim.
        public let verificationParameters: VerificationParameters?

        public init(
            javaScriptResource: [JavaScriptResource],
            executableResource: [ExecutableResource],
            trackingEvents: TrackingEvents?,
            verificiationParameters: VerificationParameters?
        ) {
            self.javaScriptResource = javaScriptResource
            self.executableResource = executableResource
            self.trackingEvents = trackingEvents
            self.verificationParameters = verificiationParameters
        }
    }
}

public extension VAST.Element.Verification {
    /// The verification vendor may provide URIs for tracking events relating to the execution of their code during
    /// the ad session.
    struct TrackingEvents {
        /// Each `<Tracking>` element is used to define a single event to be tracked by the verification vendor.
        /// Multiple tracking elements may be used to define multiple events to be tracked, but may also be used to
        /// track events of the same type for multiple parties.
        public let tracking: [Tracking]

        public init(tracking: [Tracking]) {
            self.tracking = tracking
        }
    }

    /// Each `<Tracking>` element is used to define a single event to be tracked by the verification vendor.
    /// Multiple tracking elements may be used to define multiple events to be tracked, but may also be used to
    /// track events of the same type for multiple parties.
    struct Tracking {
        /// A URI to the tracking resource for the event specified using the event attribute.
        public let content: URL
        /// A string that defines the event being tracked.
        ///
        /// One event type is currently supported:
        ///   - **verificationNotExecuted**: The player did not or was not able to execute the provided verification
        ///     code
        ///
        /// The following macros should be supported specifically in URIs for this event type:
        ///  - **[REASON]** - The reason code corresponding to the cause of failure
        ///    - **1**: Verification resource rejected. The publisher does not recognize or allow code from the vendor
        ///      in the parent `<Verification>`.
        ///    - **2**: Verification not supported. The API framework or language type of verification resources
        ///      provided are not implemented or supported by the player/SDK.
        ///    - **3**: Error during resource load. The player/SDK was not able to fetch the verification resource, or
        ///      some error occurred that the player/SDK was able to detect. *Examples of detectable errors*: malformed
        ///      resource URLs, 404 or other failed response codes, request time out. *Examples of potentially*
        ///      *undetectable errors*: parsing or runtime errors in the JS resource.
        public let event: Event

        public init(content: URL, event: Event) {
            self.content = content
            self.event = event
        }
    }
}

public extension VAST.Element.Verification.Tracking {
    /// A string that defines the event being tracked.
    ///
    /// One event type is currently supported:
    ///   - **verificationNotExecuted**: The player did not or was not able to execute the provided verification
    ///     code
    ///
    /// The following macros should be supported specifically in URIs for this event type:
    ///  - **[REASON]** - The reason code corresponding to the cause of failure
    ///    - **1**: Verification resource rejected. The publisher does not recognize or allow code from the vendor
    ///      in the parent `<Verification>`.
    ///    - **2**: Verification not supported. The API framework or language type of verification resources
    ///      provided are not implemented or supported by the player/SDK.
    ///    - **3**: Error during resource load. The player/SDK was not able to fetch the verification resource, or
    ///      some error occurred that the player/SDK was able to detect. *Examples of detectable errors*: malformed
    ///      resource URLs, 404 or other failed response codes, request time out. *Examples of potentially*
    ///      *undetectable errors*: parsing or runtime errors in the JS resource.
    enum Event: RawRepresentable {
        case verificationNotExecuted
        case unknown(String)

        public var rawValue: String {
            switch self {
            case .verificationNotExecuted: return "verificationNotExecuted"
            case .unknown(let string): return string
            }
        }

        public init(rawValue: String) {
            switch rawValue {
            case "verificationNotExecuted": self = .verificationNotExecuted
            default: self = .unknown(rawValue)
            }
        }
    }
}
