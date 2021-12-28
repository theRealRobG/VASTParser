import Foundation

public protocol AdParametersParsingContextDelegate: AnyObject {
    func adParametersParsingContext(
        _ parsingContext: VAST.Parsing.AdParametersParsingContext,
        didParse parsedContent: VAST.Element.AdParameters
    )
}

public extension VAST.Parsing {
    class AdParametersParsingContext: AnyParsingContext, UnknownElementParsingContextDelegate {
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
            let content = unknownElementDescription()
            if content == nil {
                try missingConstant("content")
            }
            localDelegate?.adParametersParsingContext(
                self,
                didParse: VAST.Element.AdParameters.make(
                    withDefaults: behaviour.defaults,
                    content: content,
                    xmlEncoded: attributes["xmlEncoded"].map { $0 == "true" }
                )
            )
        }

        public func unknownElementParsingContext(
            _ parsingContext: VAST.Parsing.UnknownElementParsingContext,
            didParse parsedContent: VAST.Parsing.UnknownElement
        ) {
            guard parsingContext === currentUnknownElementParsingContext else { return }
            unknownElement.content.append(.element(parsedContent))
            currentUnknownElementParsingContext = nil
        }

        private func unknownElementDescription() -> String? {
            let stringContent = unknownElement.content
                .reduce("") { existingContent, nextContentElement in
                    switch nextContentElement {
                    case .data(let data):
                        guard let string = String(data: data, encoding: .utf8) else { return existingContent }
                        return existingContent + string
                    case .element(let element):
                        return existingContent + element.description
                    case .string(let string):
                        return existingContent + string
                    }
                }
                .trimmingCharacters(in: .whitespacesAndNewlines)

            if stringContent.isEmpty {
                return nil
            } else {
                return stringContent
            }
        }
    }
}

extension VAST.Element.AdParameters {
    static func make(
        withDefaults defaults: VAST.Parsing.DefaultConstants,
        content: String? = nil,
        xmlEncoded: Bool? = nil
    ) -> VAST.Element.AdParameters {
        VAST.Element.AdParameters(
            content: content ?? defaults.string,
            xmlEncoded: xmlEncoded
        )
    }
}
