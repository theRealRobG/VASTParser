import Foundation

public protocol VerificationTrackingParsingContextDelegate: AnyObject {
    func trackingParsingContext(
        _ parsingContext: VAST.Parsing.Verification.TrackingParsingContext,
        didParse parsedContent: VAST.Element.Verification.Tracking
    )
}

public extension VAST.Parsing.Verification {
    class TrackingParsingContext: VAST.Parsing.AnyParsingContext {
        private var content: URL?
        private var localDelegate: VerificationTrackingParsingContextDelegate? {
            super.delegate as? VerificationTrackingParsingContextDelegate
        }

        public init(
            xmlParser: XMLParser,
            attributes: [String: String],
            errorLog: VAST.Parsing.ErrorLog,
            behaviour: VAST.Parsing.Behaviour,
            delegate: VerificationTrackingParsingContextDelegate,
            parentContext: XMLParserDelegate
        ) {
            super.init(
                xmlParser: xmlParser,
                elementName: .vastElementName.tracking,
                attributes: attributes,
                expectedElementNames: .some([]),
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
            let event = attributes["event"]
            if event == nil {
                try missingConstant("event")
            }
            if content == nil {
                try missingConstant("url")
            }
            localDelegate?.trackingParsingContext(
                self,
                didParse: VAST.Element.Verification.Tracking.make(
                    withDefaults: behaviour.defaults,
                    url: content,
                    event: event
                )
            )
        }

        public func parser(_ parser: XMLParser, foundCharacters string: String) {
            content = URL(string: string.trimmingCharacters(in: .whitespacesAndNewlines))
        }
    }
}

extension VAST.Element.Verification.Tracking {
    static func make(
        withDefaults defaults: VAST.Parsing.DefaultConstants,
        url: URL? = nil,
        event: String? = nil
    ) -> VAST.Element.Verification.Tracking {
        VAST.Element.Verification.Tracking(
            url: url ?? defaults.url,
            event: VAST.Element.Verification.Tracking.Event(rawValue: event ?? defaults.string)
        )
    }

    static func make(
        withDefaults defaults: VAST.Parsing.DefaultConstants,
        url: URL? = nil,
        event: VAST.Element.Verification.Tracking.Event?
    ) -> VAST.Element.Verification.Tracking {
        VAST.Element.Verification.Tracking(
            url: url ?? defaults.url,
            event: event ?? VAST.Element.Verification.Tracking.Event(rawValue: defaults.string)
        )
    }
}
