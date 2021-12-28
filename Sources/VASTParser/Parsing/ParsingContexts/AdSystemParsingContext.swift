import Foundation

public protocol AdSystemParsingContextDelegate: AnyObject {
    func adSystemParsingContext(
        _ parsingContext: VAST.Parsing.AdSystemParsingContext,
        didParse adSystem: VAST.Element.AdSystem
    )
}

public extension VAST.Parsing {
    class AdSystemParsingContext: AnyParsingContext {
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
            let content = unknownElement.stringContent
            if content == nil {
                try missingConstant("content")
            }
            localDelegate?.adSystemParsingContext(
                self,
                didParse: VAST.Element.AdSystem.make(
                    withDefaults: behaviour.defaults,
                    content: content,
                    version: attributes["version"]
                )
            )
        }
    }
}

extension VAST.Element.AdSystem {
    static func make(
        withDefaults defaults: VAST.Parsing.DefaultConstants,
        content: String? = nil,
        version: String? = nil
    ) -> VAST.Element.AdSystem {
        VAST.Element.AdSystem(
            content: content ?? defaults.string,
            version: version
        )
    }
}
