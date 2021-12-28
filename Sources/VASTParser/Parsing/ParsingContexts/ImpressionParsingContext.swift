import Foundation

public protocol ImpressionParsingContextDelegate: AnyObject {
    func impressionParsingContext(
        _ parsingContext: VAST.Parsing.ImpressionParsingContext,
        didParse parsedContent: VAST.Element.Impression
    )
}

public extension VAST.Parsing {
    class ImpressionParsingContext: AnyParsingContext {
        private var localDelegate: ImpressionParsingContextDelegate? {
            super.delegate as? ImpressionParsingContextDelegate
        }

        public init(
            xmlParser: XMLParser,
            attributes: [String: String],
            errorLog: ErrorLog,
            behaviour: Behaviour,
            delegate: ImpressionParsingContextDelegate,
            parentContext: XMLParserDelegate?
        ) {
            super.init(
                xmlParser: xmlParser,
                elementName: .vastElementName.impression,
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
            localDelegate?.impressionParsingContext(
                self,
                didParse: VAST.Element.Impression.make(
                    withDefaults: behaviour.defaults,
                    id: attributes["id"],
                    content: unknownElement.stringContent
                )
            )
        }
    }
}

extension VAST.Element.Impression {
    static func make(
        withDefaults defaults: VAST.Parsing.DefaultConstants,
        id: String? = nil,
        content: VAST.Element.Impression.Content? = nil
    ) -> VAST.Element.Impression {
        VAST.Element.Impression(
            id: id,
            content: content ?? .blank
        )
    }

    static func make(
        withDefaults defaults: VAST.Parsing.DefaultConstants,
        id: String? = nil,
        content: String?
    ) -> VAST.Element.Impression {
        VAST.Element.Impression(
            id: id,
            content: content.flatMap { VAST.Element.Impression.Content($0) } ?? .blank
        )
    }
}
