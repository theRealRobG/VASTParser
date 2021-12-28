extension VAST.Parsing.AnyElementParser: ClosedCaptionFileParsingContextDelegate {
    public func closedCaptionParsingContext(
        _ parsingContext: VAST.Parsing.ClosedCaptionFileParsingContext,
        didParse parsedContent: VAST.Element.ClosedCaptionFile
    ) {
        guard currentParsingContext === parsingContext else { return }
        if let element = parsedContent as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}
