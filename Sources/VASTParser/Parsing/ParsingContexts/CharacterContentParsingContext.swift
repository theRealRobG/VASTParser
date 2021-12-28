import Foundation

public protocol CharacterContentParsingContextDelegate: AnyObject {
    func stringContentParsingContext(
        _ parsingContext: VAST.Parsing.CharacterContentParsingContext,
        didParse content: String,
        fromElementName elementName: String
    )
}

public extension VAST.Parsing {
    class CharacterContentParsingContext: AnyParsingContext {
        private var content: String?
        private var localDelegate: CharacterContentParsingContextDelegate? {
            super.delegate as? CharacterContentParsingContextDelegate
        }

        public init(
            xmlParser: XMLParser,
            elementName: String,
            errorLog: ErrorLog,
            behaviour: Behaviour,
            delegate: CharacterContentParsingContextDelegate,
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
            localDelegate?.stringContentParsingContext(
                self,
                didParse: content ?? behaviour.defaults.string,
                fromElementName: elementName
            )
        }

        @objc
        public func parser(_ parser: XMLParser, foundCharacters string: String) {
            content = getStringFromFoundCharacters(string, existingContent: content)
        }
    }
}
