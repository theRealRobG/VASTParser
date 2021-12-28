import Foundation

public protocol ClickTrackingParsingContextDelegate: AnyObject {
    func clickTrackingParsingContext(
        _ parsingContext: VAST.Parsing.ClickTrackingParsingContext,
        didParse parsedContent: VAST.Element.ClickTracking
    )
}

public extension VAST.Parsing {
    class ClickTrackingParsingContext: AnyParsingContext {
        private var localDelegate: ClickTrackingParsingContextDelegate? {
            super.delegate as? ClickTrackingParsingContextDelegate
        }

        public init(
            xmlParser: XMLParser,
            attributes: [String: String],
            errorLog: ErrorLog,
            behaviour: Behaviour,
            delegate: ClickTrackingParsingContextDelegate,
            parentContext: XMLParserDelegate?
        ) {
            super.init(
                xmlParser: xmlParser,
                elementName: .vastElementName.clickTracking,
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
            let content = unknownElement.stringContent
            if content == nil {
                try missingConstant("content")
            }
            localDelegate?.clickTrackingParsingContext(
                self,
                didParse: VAST.Element.ClickTracking.make(
                    withDefaults: behaviour.defaults,
                    content: content,
                    id: attributes["id"]
                )
            )
        }
    }
}

extension VAST.Element.ClickTracking {
    static func make(
        withDefaults defaults: VAST.Parsing.DefaultConstants,
        content: URL? = nil,
        id: String? = nil
    ) -> VAST.Element.ClickTracking {
        VAST.Element.ClickTracking(
            content: content ?? defaults.url,
            id: id
        )
    }

    static func make(
        withDefaults defaults: VAST.Parsing.DefaultConstants,
        content: String?,
        id: String? = nil
    ) -> VAST.Element.ClickTracking {
        VAST.Element.ClickTracking(
            content: content.flatMap { URL(string: $0) } ?? defaults.url,
            id: id
        )
    }
}
