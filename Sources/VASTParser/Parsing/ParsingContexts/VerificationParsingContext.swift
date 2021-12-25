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
        private var currentCDATAParsingContext: CDATAContentParsingContext?

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
                didParse: VAST.Element.Verification(
                    vendor: vendor ?? behaviour.defaults.string,
                    javaScriptResource: javaScriptResource,
                    executableResource: executableResource,
                    trackingEvents: trackingEvents,
                    verificiationParameters: verificationParameters
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
                currentCDATAParsingContext = CDATAContentParsingContext(
                    xmlParser: parser,
                    elementName: .vastElementName.verificationParameters,
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

extension VAST.Parsing.VerificationParsingContext: CDATAContentParsingContextDelegate {
    public func cdataContentParsingContext(
        _ parsingContext: VAST.Parsing.CDATAContentParsingContext,
        didParse content: Data,
        fromElementName elementName: String
    ) {
        guard currentCDATAParsingContext === parsingContext else { return }
        verificationParameters = String(data: content, encoding: .utf8)?.trimmingCharacters(in: .whitespacesAndNewlines)
        currentCDATAParsingContext = nil
    }
}
