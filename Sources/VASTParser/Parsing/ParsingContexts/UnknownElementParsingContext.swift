import Foundation

public protocol UnknownElementParsingContextDelegate: AnyObject {
    func unknownElementParsingContext(
        _ parsingContext: VAST.Parsing.UnknownElementParsingContext,
        didParse parsedContent: VAST.Parsing.UnknownElement
    )
}

public extension VAST.Parsing {
    class UnknownElement: CustomStringConvertible {
        public let name: String
        public var content: [UnknownElementContent] = []
        public var attributes: [String: String] = [:]

        public init(name: String, attributes: [String: String] = [:]) {
            self.name = name
            self.attributes = attributes
        }

        public var description: String {
            var xmlString = "<\(name)"
            xmlString += attributes.isEmpty ? "" : " "
            xmlString += attributes
                .map { key, value in
                    return "\(key)=\"\(value)\""
                }
                .joined(separator: " ")
            xmlString += ">"
            for element in content {
                switch element {
                case .element(let unknownElement):
                    xmlString += unknownElement.description
                case .string(let string):
                    xmlString += string.trimmingCharacters(in: .whitespacesAndNewlines)
                case .data(let data):
                    guard let string = String(data: data, encoding: .utf8) else { continue }
                    xmlString += string.trimmingCharacters(in: .whitespacesAndNewlines)
                }
            }
            xmlString += "</\(name)>"
            return xmlString
        }
    }

    enum UnknownElementContent {
        case element(UnknownElement)
        case string(String)
        case data(Data)
    }

    class UnknownElementParsingContext: AnyParsingContext, UnknownElementParsingContextDelegate {
        private var element: UnknownElement
        private var localDelegate: UnknownElementParsingContextDelegate? {
            super.delegate as? UnknownElementParsingContextDelegate
        }
        private var currentParsingContext: UnknownElementParsingContext?

        public init(
            xmlParser: XMLParser,
            elementName: String,
            attributes: [String: String],
            errorLog: ErrorLog,
            behaviour: Behaviour,
            delegate: UnknownElementParsingContextDelegate,
            parentContext: XMLParserDelegate?
        ) {
            self.element = UnknownElement(
                name: elementName,
                attributes: attributes
            )
            super.init(
                xmlParser: xmlParser,
                elementName: elementName,
                attributes: attributes,
                expectedElementNames: .all,
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
            localDelegate?.unknownElementParsingContext(self, didParse: element)
        }

        public override func parser(
            _ parser: XMLParser,
            didStartElement elementName: String,
            attributes attributeDict: [String : String]
        ) {
            currentParsingContext = UnknownElementParsingContext(
                xmlParser: parser,
                elementName: elementName,
                attributes: attributeDict,
                errorLog: errorLog,
                behaviour: behaviour,
                delegate: self,
                parentContext: self
            )
        }

        public func unknownElementParsingContext(
            _ parsingContext: UnknownElementParsingContext,
            didParse parsedContent: VAST.Parsing.UnknownElement
        ) {
            guard parsingContext === currentParsingContext else { return }
            element.content.append(.element(parsedContent))
            currentParsingContext = nil
        }

        @objc
        public func parser(_ parser: XMLParser, foundCharacters string: String) {
            element.content.append(.string(string))
        }

        @objc
        public func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
            element.content.append(.data(CDATABlock))
        }
    }
}
