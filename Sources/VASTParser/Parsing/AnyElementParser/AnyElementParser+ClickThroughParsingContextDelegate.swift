extension VAST.Parsing.AnyElementParser: ClickThroughParsingContextDelegate {
    public func clickThroughParsingContext(
        _ parsingContext: VAST.Parsing.ClickThroughParsingContext,
        didParse parsedContent: VAST.Element.ClickThrough
    ) {
        guard currentParsingContext === parsingContext else { return }
        if let element = parsedContent as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}
