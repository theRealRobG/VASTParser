import Foundation

extension VAST.Parsing {
    open class AnyParsingContext: NSObject, XMLParserDelegate {
        public var unknownElement: UnknownElement
        public let elementName: String
        public let attributes: [String: String]
        public let expectedElementNames: Set<String>
        public let shouldAllowAllNames: Bool
        public let errorLog: ErrorLog
        public let behaviour: Behaviour
        public var delegate: Any?
        public weak var parentContext: XMLParserDelegate?

        private var unexpectedElementNames = [String]() {
            didSet { didGetUnexpectedElementStart = true }
        }
        private var didGetUnexpectedElementStart = false
        private var didGetUnexpectedElementEnd = false

        public init(
            xmlParser: XMLParser,
            elementName: String,
            attributes: [String: String],
            expectedElementNames: ExpectedElementNames,
            errorLog: ErrorLog,
            behaviour: Behaviour,
            delegate: Any,
            parentContext: XMLParserDelegate?
        ) {
            self.elementName = elementName
            self.attributes = attributes
            switch expectedElementNames {
            case .some(let names):
                self.expectedElementNames = names
                self.shouldAllowAllNames = false
            case .all:
                self.expectedElementNames = []
                self.shouldAllowAllNames = true
            }
            self.errorLog = errorLog
            self.behaviour = behaviour
            self.delegate = delegate
            self.parentContext = parentContext
            self.unknownElement = UnknownElement(name: elementName, attributes: attributes)
            super.init()
            xmlParser.delegate = self
        }

        open func parser(
            _ parser: XMLParser,
            didStartElement elementName: String,
            attributes attributeDict: [String: String]
        ) {
            assertionFailure("Must be implemented in subclass")
        }

        open func didCompleteParsing(
            missingConstant: (String) throws -> Void,
            missingElement: (String) throws -> Void
        ) throws {
            assertionFailure("Must be implemented in subclass")
        }

        public func parser(
            _ parser: XMLParser,
            didStartElement elementName: String,
            namespaceURI: String?,
            qualifiedName qName: String?,
            attributes attributeDict: [String : String] = [:]
        ) {
            if shouldAllowAllNames {
                self.parser(parser, didStartElement: elementName, attributes: attributeDict)
                return
            }
            guard expectedElementNames.contains(elementName) else {
                errorLog.append(
                    .unexpectedStartOfElement(
                        parentElementName: self.elementName,
                        unexpectedElementName: elementName
                    )
                )
                unexpectedElementNames.append(elementName)
                return
            }
            guard unexpectedElementNames.isEmpty else {
                unexpectedElementNames.append(elementName)
                return
            }
            self.parser(parser, didStartElement: elementName, attributes: attributeDict)
        }

        public func parser(
            _ parser: XMLParser,
            didEndElement elementName: String,
            namespaceURI: String?,
            qualifiedName qName: String?
        ) {
            guard unexpectedElementNames.isEmpty else {
                if unexpectedElementNames.last == elementName {
                    unexpectedElementNames.removeLast()
                }
                return
            }
            guard elementName == self.elementName else {
                errorLog.append(
                    .unexpectedEndOfElement(
                        parentElementName: self.elementName,
                        unexpectedElementName: elementName
                    )
                )
                didGetUnexpectedElementEnd = true
                return
            }
            if didGetUnexpectedElementStart, !behaviour.strictness.contains(.allowUnexpectedElementStarts) {
                unlink(parser)
                return
            }
            if didGetUnexpectedElementEnd, !behaviour.strictness.contains(.allowUnexpectedElementEnds) {
                unlink(parser)
                return
            }
            do {
                try didCompleteParsing(
                    missingConstant: {
                        let error = VASTParsingError.missingRequiredProperty(
                            parentElementName: elementName,
                            missingPropertyName: $0
                        )
                        errorLog.append(error)
                        if !behaviour.strictness.contains(.allowDefaultRequiredConstants) {
                            throw error
                        }
                    },
                    missingElement: {
                        let error = VASTParsingError.missingRequiredProperty(
                            parentElementName: elementName,
                            missingPropertyName: $0
                        )
                        errorLog.append(error)
                        if !behaviour.strictness.contains(.allowDefaultRequiredElements) {
                            throw error
                        }
                    }
                )
            } catch {}
            unlink(parser)
        }

        public func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
            unknownElement.content.append(.data(CDATABlock))
        }

        public func parser(_ parser: XMLParser, foundCharacters string: String) {
            unknownElement.content.append(.string(string))
        }

        func getStringFromFoundCharacters(_ string: String, existingContent content: String?) -> String? {
            let newContent = (content ?? "") + string.trimmingCharacters(in: .whitespacesAndNewlines)
            return newContent.isEmpty ? nil : newContent
        }

        func getStringFromFoundCDATA(_ CDATA: Data, existingContent content: String?) -> String? {
            guard let stringData = String(data: CDATA, encoding: .utf8) else { return nil }
            return getStringFromFoundCharacters(stringData, existingContent: content)
        }

        private func unlink(_ parser: XMLParser) {
            parser.delegate = parentContext
            delegate = nil
            parentContext = nil
        }
    }
}

public extension VAST.Parsing.AnyParsingContext {
    enum ExpectedElementNames {
        case some(Set<String>)
        case all
    }
}
