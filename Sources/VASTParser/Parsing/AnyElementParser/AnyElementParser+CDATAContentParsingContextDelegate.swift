import Foundation

extension VAST.Parsing.AnyElementParser: CDATAContentParsingContextDelegate {
    public func cdataContentParsingContext(
        _ parsingContext: VAST.Parsing.CDATAContentParsingContext,
        didParse parsedContent: Data,
        fromElementName elementName: String
    ) {
        guard currentParsingContext === parsingContext else { return }
        if let element = parsedContent as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}
