import Foundation

public protocol JavaScriptResourceParsingContextDelegate: AnyObject {
    func javaScriptResourceParsingContext(
        _ parsingContext: VAST.Parsing.JavaScriptResourceParsingContext,
        didParse parsedContent: VAST.Element.JavaScriptResource
    )
}

public extension VAST.Parsing {
    class JavaScriptResourceParsingContext: AnyParsingContext {
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
            let content = unknownElement.stringContent.flatMap { URL(string: $0) }
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
                didParse: VAST.Element.JavaScriptResource.make(
                    withDefaults: behaviour.defaults,
                    content: content,
                    apiFramework: apiFramework,
                    browserOptional: browserOptional == "true"
                )
            )
        }
    }
}

extension VAST.Element.JavaScriptResource {
    static func make(
        withDefaults defaults: VAST.Parsing.DefaultConstants,
        content: URL? = nil,
        apiFramework: String? = nil,
        browserOptional: Bool = false
    ) -> VAST.Element.JavaScriptResource {
        VAST.Element.JavaScriptResource(
            content: content ?? defaults.url,
            apiFramework: apiFramework ?? defaults.string,
            browserOptional: browserOptional
        )
    }
}
