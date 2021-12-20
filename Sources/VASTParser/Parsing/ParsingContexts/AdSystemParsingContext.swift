import Foundation

public protocol AdSystemParsingContextDelegate: AnyObject {
    func adSystemParsingContext(
        _ parsingContext: VAST.Parsing.AdSystemParsingContext,
        didParse adSystem: VAST.Element.AdSystem
    )
}

public extension VAST.Parsing {
    class AdSystemParsingContext: AnyParsingContext {
        private var content: String?
        private var localDelegate: AdSystemParsingContextDelegate? {
            super.delegate as? AdSystemParsingContextDelegate
        }

        public init(
            xmlParser: XMLParser,
            attributes: [String: String],
            errorLog: ErrorLog,
            behaviour: Behaviour,
            delegate: AdSystemParsingContextDelegate,
            parentContext: XMLParserDelegate?
        ) {
            super.init(
                xmlParser: xmlParser,
                elementName: .vastElementName.adSystem,
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
            localDelegate?.adSystemParsingContext(
                self,
                didParse: VAST.Element.AdSystem(
                    content: content ?? behaviour.defaults.string,
                    version: attributes["version"]
                )
            )
        }

        @objc
        public func parser(_ parser: XMLParser, foundCharacters string: String) {
            if let content = self.content {
                self.content = content + string.trimmingCharacters(in: .whitespacesAndNewlines)
            } else {
                self.content = string.trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
    }
}

