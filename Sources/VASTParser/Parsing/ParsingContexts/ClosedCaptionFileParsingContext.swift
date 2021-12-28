import Foundation

public protocol ClosedCaptionFileParsingContextDelegate: AnyObject {
    func closedCaptionParsingContext(
        _ parsingContext: VAST.Parsing.ClosedCaptionFileParsingContext,
        didParse parsedContent: VAST.Element.ClosedCaptionFile
    )
}

public extension VAST.Parsing {
    class ClosedCaptionFileParsingContext: AnyParsingContext {
        private var localDelegate: ClosedCaptionFileParsingContextDelegate? {
            super.delegate as? ClosedCaptionFileParsingContextDelegate
        }

        public init(
            xmlParser: XMLParser,
            attributes: [String: String],
            errorLog: ErrorLog,
            behaviour: Behaviour,
            delegate: ClosedCaptionFileParsingContextDelegate,
            parentContext: XMLParserDelegate?
        ) {
            super.init(
                xmlParser: xmlParser,
                elementName: .vastElementName.closedCaptionFile,
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
            localDelegate?.closedCaptionParsingContext(
                self,
                didParse: VAST.Element.ClosedCaptionFile.make(
                    withDefaults: behaviour.defaults,
                    content: content,
                    type: attributes["type"],
                    language: attributes["language"]
                )
            )
        }
    }
}

extension VAST.Element.ClosedCaptionFile {
    static func make(
        withDefaults defaults: VAST.Parsing.DefaultConstants,
        content: URL? = nil,
        type: String? = nil,
        language: String? = nil
    ) -> VAST.Element.ClosedCaptionFile {
        VAST.Element.ClosedCaptionFile(
            content: content ?? defaults.url,
            type: type,
            language: language
        )
    }

    static func make(
        withDefaults defaults: VAST.Parsing.DefaultConstants,
        content: String?,
        type: String? = nil,
        language: String? = nil
    ) -> VAST.Element.ClosedCaptionFile {
        VAST.Element.ClosedCaptionFile(
            content: content.flatMap { URL(string: $0) } ?? defaults.url,
            type: type,
            language: language
        )
    }
}
