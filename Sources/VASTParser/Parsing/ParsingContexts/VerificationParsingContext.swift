import Foundation

public protocol VerificationParsingContextDelegate: AnyObject {
    func verificationParsingContext(
        _ parsingContext: VAST.Parsing.VerificationParsingContext,
        didParse parsedContent: VAST.Element.Verification
    )
}

public extension VAST.Parsing {
    struct Verification {}
}

public extension VAST.Parsing {
    class VerificationParsingContext: AnyParsingContext {
        private var javaScriptResource = [VAST.Element.JavaScriptResource]()
        private var executableResource = [VAST.Element.ExecutableResource]()
        private var trackingEvents = VAST.Element.Verification.TrackingEvents()
        private var verificationParameters: VAST.Element.VerificationParameters?
        private var localDelegate: VerificationParsingContextDelegate? {
            super.delegate as? VerificationParsingContextDelegate
        }

        private var currentJavaScriptResourceParsingContext: JavaScriptResourceParsingContext?
        private var currentExecutableResourceParsingContext: ExecutableResourceParsingContext?
        private var currentTrackingEventsParsingContext: Verification.TrackingEventsParsingContext?
        private var currentUnknownElementParsingContext: UnknownElementParsingContext?

        public init(
            xmlParser: XMLParser,
            attributes: [String: String],
            errorLog: ErrorLog,
            behaviour: Behaviour,
            delegate: VerificationParsingContextDelegate,
            parentContext: XMLParserDelegate?
        ) {
            super.init(
                xmlParser: xmlParser,
                elementName: .vastElementName.verification,
                attributes: attributes,
                expectedElementNames: .some([
                    .vastElementName.javaScriptResource,
                    .vastElementName.executableResource,
                    .vastElementName.trackingEvents,
                    .vastElementName.verificationParameters
                ]),
                errorLog: errorLog,
                behaviour: behaviour,
                delegate: delegate,
                parentContext: parentContext
            )
        }

        public override func didCompleteParsing(
            missingConstant: (String) throws -> Void,
            missingElement: (String) throws -> Void
        ) throws {
            let vendor = attributes["vendor"]
            if vendor == nil {
                try missingConstant("vendor")
            }
            localDelegate?.verificationParsingContext(
                self,
                didParse: VAST.Element.Verification.make(
                    withDefaults: behaviour.defaults,
                    vendor: vendor,
                    javaScriptResource: javaScriptResource,
                    executableResource: executableResource,
                    trackingEvents: trackingEvents,
                    verificationParameters: verificationParameters
                )
            )
        }

        public override func parser(
            _ parser: XMLParser,
            didStartElement elementName: String,
            attributes attributeDict: [String: String]
        ) {
            switch elementName {
            case .vastElementName.javaScriptResource:
                currentJavaScriptResourceParsingContext = JavaScriptResourceParsingContext(
                    xmlParser: parser,
                    attributes: attributeDict,
                    errorLog: errorLog,
                    behaviour: behaviour,
                    delegate: self,
                    parentContext: self
                )
            case .vastElementName.executableResource:
                currentExecutableResourceParsingContext = ExecutableResourceParsingContext(
                    xmlParser: parser,
                    attributes: attributeDict,
                    errorLog: errorLog,
                    behaviour: behaviour,
                    delegate: self,
                    parentContext: self
                )
            case .vastElementName.trackingEvents:
                currentTrackingEventsParsingContext = Verification.TrackingEventsParsingContext(
                    xmlParser: parser,
                    errorLog: errorLog,
                    behaviour: behaviour,
                    delegate: self,
                    parentContext: self
                )
            case .vastElementName.verificationParameters:
                currentUnknownElementParsingContext = UnknownElementParsingContext(
                    xmlParser: parser,
                    elementName: .vastElementName.verificationParameters,
                    attributes: [:],
                    errorLog: errorLog,
                    behaviour: behaviour,
                    delegate: self,
                    parentContext: self
                )
            default:
                break
            }
        }
    }
}

extension VAST.Parsing.VerificationParsingContext: JavaScriptResourceParsingContextDelegate {
    public func javaScriptResourceParsingContext(
        _ parsingContext: VAST.Parsing.JavaScriptResourceParsingContext,
        didParse parsedContent: VAST.Element.JavaScriptResource
    ) {
        guard currentJavaScriptResourceParsingContext === parsingContext else { return }
        javaScriptResource.append(parsedContent)
        currentJavaScriptResourceParsingContext = nil
    }
}

extension VAST.Parsing.VerificationParsingContext: ExecutableResourceParsingContextDelegate {
    public func executableResourceParsingContext(
        _ parsingContext: VAST.Parsing.ExecutableResourceParsingContext,
        didParse parsedContent: VAST.Element.ExecutableResource
    ) {
        guard currentExecutableResourceParsingContext === parsingContext else { return }
        executableResource.append(parsedContent)
        currentExecutableResourceParsingContext = nil
    }
}

extension VAST.Parsing.VerificationParsingContext: VerificationTrackingEventsParsingContextDelegate {
    public func trackingEventsParsingContext(
        _ parsingContext: VAST.Parsing.Verification.TrackingEventsParsingContext,
        didParse parsedContent: [VAST.Element.Verification.Tracking]
    ) {
        guard currentTrackingEventsParsingContext === parsingContext else { return }
        trackingEvents = parsedContent
        currentTrackingEventsParsingContext = nil
    }
}

extension VAST.Parsing.VerificationParsingContext: UnknownElementParsingContextDelegate {
    public func unknownElementParsingContext(
        _ parsingContext: VAST.Parsing.UnknownElementParsingContext,
        didParse parsedContent: VAST.Parsing.UnknownElement
    ) {
        guard currentUnknownElementParsingContext === parsingContext else { return }
        verificationParameters = parsedContent.stringContent
        currentUnknownElementParsingContext = nil
    }
}

extension VAST.Element.Verification {
    static func make(
        withDefaults defaults: VAST.Parsing.DefaultConstants,
        vendor: String? = nil,
        javaScriptResource: [VAST.Element.JavaScriptResource] = [],
        executableResource: [VAST.Element.ExecutableResource] = [],
        trackingEvents: TrackingEvents = [],
        verificationParameters: VAST.Element.VerificationParameters? = nil
    ) -> VAST.Element.Verification {
        VAST.Element.Verification(
            vendor: vendor ?? defaults.string,
            javaScriptResource: javaScriptResource,
            executableResource: executableResource,
            trackingEvents: trackingEvents,
            verificationParameters: verificationParameters
        )
    }
}
