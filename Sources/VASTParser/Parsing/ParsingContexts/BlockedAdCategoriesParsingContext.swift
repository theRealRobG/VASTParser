import Foundation

public protocol BlockedAdCategoriesParsingContextDelegate: AnyObject {
    func blockedAdCategoriesParsingContext(
        _ parsingContext: VAST.Parsing.BlockedAdCategoriesParsingContext,
        didParse parsedContent: VAST.Element.BlockedAdCategories
    )
}

public extension VAST.Parsing {
    class BlockedAdCategoriesParsingContext: AnyParsingContext {
        private var content: String?
        private var localDelegate: BlockedAdCategoriesParsingContextDelegate? {
            super.delegate as? BlockedAdCategoriesParsingContextDelegate
        }

        public init(
            xmlParser: XMLParser,
            attributes: [String: String],
            errorLog: ErrorLog,
            behaviour: Behaviour,
            delegate: BlockedAdCategoriesParsingContextDelegate,
            parentContext: XMLParserDelegate?
        ) {
            super.init(
                xmlParser: xmlParser,
                elementName: .vastElementName.blockedAdCategories,
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
            localDelegate?.blockedAdCategoriesParsingContext(
                self,
                didParse: VAST.Element.BlockedAdCategories.make(
                    withDefaults: behaviour.defaults,
                    content: content,
                    authority: attributes["authority"]
                )
            )
        }

        public func parser(_ parser: XMLParser, foundCharacters string: String) {
            content = getStringFromFoundCharacters(string, existingContent: content)
        }
    }
}

extension VAST.Element.BlockedAdCategories {
    static func make(
        withDefaults defaults: VAST.Parsing.DefaultConstants,
        content: String? = nil,
        authority: String? = nil
    ) -> VAST.Element.BlockedAdCategories {
        VAST.Element.BlockedAdCategories(
            content: content ?? defaults.string,
            authority: authority.flatMap { URL(string: $0) }
        )
    }

    static func make(
        withDefaults defaults: VAST.Parsing.DefaultConstants,
        content: String? = nil,
        authority: URL?
    ) -> VAST.Element.BlockedAdCategories {
        VAST.Element.BlockedAdCategories(
            content: content ?? defaults.string,
            authority: authority
        )
    }
}
