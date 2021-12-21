import Foundation

public protocol JavaScriptResourceParsingContextDelegate: AnyObject {
    func javaScriptResourceParsingContext(
        _ parsingContext: VAST.Parsing.JavaScriptResourceParsingContext,
        didParse parsedContent: VAST.Element.JavaScriptResource
    )
}

public extension VAST.Parsing {
    class JavaScriptResourceParsingContext: AnyParsingContext {
        private var content: URL?
        private var localDelegate: JavaScriptResourceParsingContextDelegate? {
            super.delegate as? JavaScriptResourceParsingContextDelegate
        }

        public init(
            xmlParser: XMLParser,
            attributes: [String: String],
            errorLog: ErrorLog,
            behaviour: Behaviour,
            delegate: JavaScriptResourceParsingContextDelegate,
            parentContext: XMLParserDelegate?
        ) {
            super.init(
                xmlParser: xmlParser,
                elementName: .vastElementName.javaScriptResource,
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
            let apiFramework = attributes["apiFramework"]
            if apiFramework == nil {
                try missingConstant("apiFramework")
            }
            let browserOptional = attributes["browserOptional"]
            if browserOptional == nil {
                try missingConstant("browserOptional")
            }
            localDelegate?.javaScriptResourceParsingContext(
                self,
                didParse: VAST.Element.JavaScriptResource(
                    content: content ?? behaviour.defaults.url,
                    apiFramework: apiFramework ?? behaviour.defaults.string,
                    browserOptional: browserOptional == "true"
                )
            )
        }

        @objc
        public func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
            content = String(data: CDATABlock, encoding: .utf8).flatMap { URL(string: $0) }
        }
    }
}
