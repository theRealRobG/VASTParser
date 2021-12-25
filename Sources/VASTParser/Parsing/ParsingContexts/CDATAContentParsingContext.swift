import Foundation

public protocol CDATAContentParsingContextDelegate: AnyObject {
    func cdataContentParsingContext(
        _ parsingContext: VAST.Parsing.CDATAContentParsingContext,
        didParse content: Data,
        fromElementName elementName: String
    )
}

public extension VAST.Parsing {
    class CDATAContentParsingContext: AnyParsingContext {
        private var content: Data?
        private var localDelegate: CDATAContentParsingContextDelegate? {
            super.delegate as? CDATAContentParsingContextDelegate
        }

        public init(
            xmlParser: XMLParser,
            elementName: String,
            errorLog: ErrorLog,
            behaviour: Behaviour,
            delegate: CDATAContentParsingContextDelegate,
            parentContext: XMLParserDelegate?
        ) {
            super.init(
                xmlParser: xmlParser,
                elementName: elementName,
                attributes: [:],
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
            localDelegate?.cdataContentParsingContext(
                self,
                didParse: content ?? behaviour.defaults.data,
                fromElementName: elementName
            )
        }

        @objc
        public func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
            content = CDATABlock
        }
    }
}
