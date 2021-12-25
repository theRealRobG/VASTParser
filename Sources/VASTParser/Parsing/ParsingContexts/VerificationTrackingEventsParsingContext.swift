import Foundation

public protocol VerificationTrackingEventsParsingContextDelegate: AnyObject {
    func trackingEventsParsingContext(
        _ parsingContext: VAST.Parsing.Verification.TrackingEventsParsingContext,
        didParse parsedContent: [VAST.Element.Verification.Tracking]
    )
}

public extension VAST.Parsing.Verification {
    class TrackingEventsParsingContext: VAST.Parsing.AnyParsingContext {
        private var tracking = [VAST.Element.Verification.Tracking]()
        private var localDelegate: VerificationTrackingEventsParsingContextDelegate? {
            super.delegate as? VerificationTrackingEventsParsingContextDelegate
        }

        private var currentTrackingParsingContext: TrackingParsingContext?

        public init(
            xmlParser: XMLParser,
            errorLog: VAST.Parsing.ErrorLog,
            behaviour: VAST.Parsing.Behaviour,
            delegate: VerificationTrackingEventsParsingContextDelegate,
            parentContext: XMLParserDelegate?
        ) {
            super.init(
                xmlParser: xmlParser,
                elementName: .vastElementName.trackingEvents,
                attributes: [:],
                expectedElementNames: .some([.vastElementName.tracking]),
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
            localDelegate?.trackingEventsParsingContext(self, didParse: tracking)
        }

        public override func parser(
            _ parser: XMLParser,
            didStartElement elementName: String,
            attributes attributeDict: [String: String]
        ) {
            guard elementName == .vastElementName.tracking else { return }
            currentTrackingParsingContext = TrackingParsingContext(
                xmlParser: parser,
                attributes: attributeDict,
                errorLog: errorLog,
                behaviour: behaviour,
                delegate: self,
                parentContext: self
            )
        }
    }
}

extension VAST.Parsing.Verification.TrackingEventsParsingContext: VerificationTrackingParsingContextDelegate {
    public func trackingParsingContext(
        _ parsingContext: VAST.Parsing.Verification.TrackingParsingContext,
        didParse parsedContent: VAST.Element.Verification.Tracking
    ) {
        guard currentTrackingParsingContext === parsingContext else { return }
        tracking.append(parsedContent)
        currentTrackingParsingContext = nil
    }
}
