import Foundation

public protocol ClosedCaptionFilesParsingContextDelegate: AnyObject {
    func closedCaptionFilesParsingContext(
        _ parsingContext: VAST.Parsing.ClosedCaptionFilesParsingContext,
        didParse parsedContent: VAST.Element.ClosedCaptionFiles
    )
}

public extension VAST.Parsing {
    class ClosedCaptionFilesParsingContext: AnyParsingContext {
        private var content = [VAST.Element.ClosedCaptionFile]()
        private var localDelegate: ClosedCaptionFilesParsingContextDelegate? {
            super.delegate as? ClosedCaptionFilesParsingContextDelegate
        }
        private var currentClosedCaptionFileParsingContext: ClosedCaptionFileParsingContext?

        public init(
            xmlParser: XMLParser,
            errorLog: ErrorLog,
            behaviour: Behaviour,
            delegate: ClosedCaptionFilesParsingContextDelegate,
            parentContext: XMLParserDelegate?
        ) {
            super.init(
                xmlParser: xmlParser,
                elementName: .vastElementName.closedCaptionFiles,
                attributes: [:],
                expectedElementNames: .some([.vastElementName.closedCaptionFile]),
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
            localDelegate?.closedCaptionFilesParsingContext(self, didParse: content)
        }

        public override func parser(
            _ parser: XMLParser,
            didStartElement elementName: String,
            attributes attributeDict: [String: String]
        ) {
            currentClosedCaptionFileParsingContext = ClosedCaptionFileParsingContext(
                xmlParser: parser,
                attributes: attributeDict,
                errorLog: errorLog,
                behaviour: behaviour,
                delegate: self,
                parentContext: self
            )
        }
    }
}

extension VAST.Parsing.ClosedCaptionFilesParsingContext: ClosedCaptionFileParsingContextDelegate {
    public func closedCaptionParsingContext(
        _ parsingContext: VAST.Parsing.ClosedCaptionFileParsingContext,
        didParse parsedContent: VAST.Element.ClosedCaptionFile
    ) {
        guard currentClosedCaptionFileParsingContext === parsingContext else { return }
        content.append(parsedContent)
        currentClosedCaptionFileParsingContext = nil
    }
}
