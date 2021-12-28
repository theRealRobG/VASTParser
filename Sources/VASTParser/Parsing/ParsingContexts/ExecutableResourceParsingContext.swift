import Foundation

public protocol ExecutableResourceParsingContextDelegate: AnyObject {
    func executableResourceParsingContext(
        _ parsingContext: VAST.Parsing.ExecutableResourceParsingContext,
        didParse parsedContent: VAST.Element.ExecutableResource
    )
}

public extension VAST.Parsing {
    class ExecutableResourceParsingContext: AnyParsingContext {
        private var localDelegate: ExecutableResourceParsingContextDelegate? {
            super.delegate as? ExecutableResourceParsingContextDelegate
        }

        public init(
            xmlParser: XMLParser,
            attributes: [String: String],
            errorLog: ErrorLog,
            behaviour: Behaviour,
            delegate: ExecutableResourceParsingContextDelegate,
            parentContext: XMLParserDelegate?
        ) {
            super.init(
                xmlParser: xmlParser,
                elementName: .vastElementName.executableResource,
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
            let apiFramework = attributes["apiFramework"]
            if apiFramework == nil {
                try missingConstant("apiFramework")
            }
            let type = attributes["type"]
            if type == nil {
                try missingConstant("type")
            }
            localDelegate?.executableResourceParsingContext(
                self,
                didParse: VAST.Element.ExecutableResource.make(
                    withDefaults: behaviour.defaults,
                    content: content,
                    apiFramework: apiFramework,
                    type: type
                )
            )
        }
    }
}

extension VAST.Element.ExecutableResource {
    static func make(
        withDefaults defaults: VAST.Parsing.DefaultConstants,
        content: String? = nil,
        apiFramework: String? = nil,
        type: String? = nil
    ) -> VAST.Element.ExecutableResource {
        VAST.Element.ExecutableResource(
            content: content ?? defaults.string,
            apiFramework: apiFramework ?? defaults.string,
            type: type ?? defaults.string
        )
    }
}
