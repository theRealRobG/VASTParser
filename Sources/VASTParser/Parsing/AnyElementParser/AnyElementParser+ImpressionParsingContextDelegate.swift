extension VAST.Parsing.AnyElementParser: ImpressionParsingContextDelegate {
    public func impressionParsingContext(
        _ parsingContext: VAST.Parsing.ImpressionParsingContext,
        didParse parsedContent: VAST.Element.Impression
    ) {
        guard currentParsingContext === parsingContext else { return }
        if let element = parsedContent as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}
