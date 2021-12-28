import Foundation

public protocol ClickThroughParsingContextDelegate: AnyObject {
    func clickThroughParsingContext(
        _ parsingContext: VAST.Parsing.ClickThroughParsingContext,
        didParse parsedContent: VAST.Element.ClickThrough
    )
}

public extension VAST.Parsing {
    class ClickThroughParsingContext: AnyParsingContext {
        private var content: URL?
        private var localDelegate: ClickThroughParsingContextDelegate? {
            super.delegate as? ClickThroughParsingContextDelegate
        }

        public init(
            xmlParser: XMLParser,
            attributes: [String: String],
            errorLog: ErrorLog,
            behaviour: Behaviour,
            delegate: ClickThroughParsingContextDelegate,
            parentContext: XMLParserDelegate?
        ) {
            super.init(
                xmlParser: xmlParser,
                elementName: .vastElementName.clickThrough,
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
            if content == nil {
                try missingConstant("content")
            }
            localDelegate?.clickThroughParsingContext(
                self,
                didParse: VAST.Element.ClickThrough.make(
                    withDefaults: behaviour.defaults,
                    content: content,
                    id: attributes["id"]
                )
            )
        }

        public func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
            content = String(data: CDATABlock, encoding: .utf8).flatMap { URL(string: $0) }
        }
    }
}

extension VAST.Element.ClickThrough {
    static func make(
        withDefaults defaults: VAST.Parsing.DefaultConstants,
        content: URL? = nil,
        id: String? = nil
    ) -> VAST.Element.ClickThrough {
        VAST.Element.ClickThrough(
            content: content ?? defaults.url,
            id: id
        )
    }

    static func make(
        withDefaults defaults: VAST.Parsing.DefaultConstants,
        content: String?,
        id: String? = nil
    ) -> VAST.Element.ClickThrough {
        make(withDefaults: defaults, content: content.flatMap { URL(string: $0) }, id: id)
    }
}
