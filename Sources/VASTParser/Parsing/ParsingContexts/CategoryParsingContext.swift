import Foundation

public protocol CategoryParsingContextDelegate: AnyObject {
    func categoryParsingContext(
        _ parsingContext: VAST.Parsing.CategoryParsingContext,
        didParse parsedContent: VAST.Element.Category
    )
}

public extension VAST.Parsing {
    class CategoryParsingContext: AnyParsingContext {
        private var localDelegate: CategoryParsingContextDelegate? {
            super.delegate as? CategoryParsingContextDelegate
        }

        public init(
            xmlParser: XMLParser,
            attributes: [String: String],
            errorLog: ErrorLog,
            behaviour: Behaviour,
            delegate: CategoryParsingContextDelegate,
            parentContext: XMLParserDelegate?
        ) {
            super.init(
                xmlParser: xmlParser,
                elementName: .vastElementName.category,
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
            localDelegate?.categoryParsingContext(
                self,
                didParse: VAST.Element.Category.make(
                    withDefaults: behaviour.defaults,
                    authority: attributes["authority"],
                    content: content
                )
            )
        }
    }
}

extension VAST.Element.Category {
    static func make(
        withDefaults defaults: VAST.Parsing.DefaultConstants,
        authority: String? = nil,
        content: String? = nil
    ) -> VAST.Element.Category {
        VAST.Element.Category(
            authority: authority.flatMap { URL(string: $0) },
            content: content ?? defaults.string
        )
    }

    static func make(
        withDefaults defaults: VAST.Parsing.DefaultConstants,
        authority: URL?,
        content: String? = nil
    ) -> VAST.Element.Category {
        VAST.Element.Category(
            authority: authority,
            content: content ?? defaults.string
        )
    }
}
