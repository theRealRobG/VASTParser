extension VAST.Parsing.AnyElementParser: ClosedCaptionFilesParsingContextDelegate {
    public func closedCaptionFilesParsingContext(
        _ parsingContext: VAST.Parsing.ClosedCaptionFilesParsingContext,
        didParse parsedContent: VAST.Element.ClosedCaptionFiles
    ) {
        guard currentParsingContext === parsingContext else { return }
        if let element = parsedContent as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}
