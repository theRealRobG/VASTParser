import Foundation

public protocol AdvertiserParsingContextDelegate: AnyObject {
    func advertiserParsingContext(
        _ parsingContext: VAST.Parsing.AdvertiserParsingContext,
        parsedContent: VAST.Element.Advertiser
    )
}

public extension VAST.Parsing {
    class AdvertiserParsingContext: AnyParsingContext {
        private var localDelegate: AdvertiserParsingContextDelegate? {
            super.delegate as? AdvertiserParsingContextDelegate
        }

        public init(
            xmlParser: XMLParser,
            attributes: [String: String],
            errorLog: ErrorLog,
            behaviour: Behaviour,
            delegate: AdvertiserParsingContextDelegate,
            parentContext: XMLParserDelegate?
        ) {
            super.init(
                xmlParser: xmlParser,
                elementName: .vastElementName.advertiser,
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
            localDelegate?.advertiserParsingContext(
                self,
                parsedContent: VAST.Element.Advertiser.make(
                    withDefaults: behaviour.defaults,
                    id: attributes["id"],
                    content: content
                )
            )
        }
    }
}

extension VAST.Element.Advertiser {
    static func make(
        withDefaults defaults: VAST.Parsing.DefaultConstants,
        id: String? = nil,
        content: String? = nil
    ) -> VAST.Element.Advertiser {
        VAST.Element.Advertiser(
            id: id,
            content: content ?? defaults.string
        )
    }
}
