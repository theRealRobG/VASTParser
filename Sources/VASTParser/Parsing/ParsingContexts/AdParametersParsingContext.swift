import Foundation

public protocol AdParametersParsingContextDelegate: AnyObject {
    func adParametersParsingContext(
        _ parsingContext: VAST.Parsing.AdParametersParsingContext,
        didParse adParameters: VAST.Element.AdParameters
    )
}

public extension VAST.Parsing {
    class AdParametersParsingContext: AnyParsingContext, UnknownElementParsingContextDelegate {
        private var content: String?
        private var localDelegate: AdParametersParsingContextDelegate? {
            super.delegate as? AdParametersParsingContextDelegate
        }
        private var currentUnknownElementParsingContext: UnknownElementParsingContext?

        public init(
            xmlParser: XMLParser,
            attributes: [String: String],
            errorLog: ErrorLog,
            behaviour: Behaviour,
            delegate: AdParametersParsingContextDelegate,
            parentContext: XMLParserDelegate?
        ) {
            super.init(
                xmlParser: xmlParser,
                elementName: .vastElementName.adParameters,
                attributes: attributes,
                expectedElementNames: .all,
                errorLog: errorLog,
                behaviour: behaviour,
                delegate: delegate,
                parentContext: parentContext
            )
        }

        public override func parser(
            _ parser: XMLParser,
            didStartElement elementName: String,
            attributes attributeDict: [String: String]
        ) {
            currentUnknownElementParsingContext = UnknownElementParsingContext(
                xmlParser: parser,
                elementName: elementName,
                attributes: attributeDict,
                errorLog: errorLog,
                behaviour: behaviour,
                delegate: self,
                parentContext: self
            )
        }

        public override func didCompleteParsing(
            missingConstant: (String) throws -> Void,
            missingElement: (String) throws -> Void
        ) throws {
            if content == nil {
                try missingConstant("content")
            }
            var isXMLEncoded: Bool?
            if let xmlEncoded = attributes["xmlEncoded"] {
                isXMLEncoded = xmlEncoded == "true"
            }
            localDelegate?.adParametersParsingContext(
                self,
                didParse: VAST.Element.AdParameters(
                    content: content ?? behaviour.defaults.string,
                    xmlEncoded: isXMLEncoded
                )
            )
        }

        public func unknownElementParsingContext(
            _ parsingContext: VAST.Parsing.UnknownElementParsingContext,
            didParse parsedContent: VAST.Parsing.UnknownElement
        ) {
            guard parsingContext === currentUnknownElementParsingContext else { return }
            if let content = self.content {
                self.content = content + parsedContent.description
            } else {
                self.content = parsedContent.description
            }
            currentUnknownElementParsingContext = nil
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
