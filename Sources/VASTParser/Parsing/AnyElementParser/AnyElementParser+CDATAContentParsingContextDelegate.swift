import Foundation

extension VAST.Parsing.AnyElementParser: CDATAContentParsingContextDelegate {
    public func cdataContentParsingContext(
        _ parsingContext: VAST.Parsing.CDATAContentParsingContext,
        didParse content: Data,
        fromElementName elementName: String
    ) {
        guard parsingContext === currentParsingContext else { return }
        if let element = content as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}
