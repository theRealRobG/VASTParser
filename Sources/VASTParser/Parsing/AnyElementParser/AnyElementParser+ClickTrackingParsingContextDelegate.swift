extension VAST.Parsing.AnyElementParser: ClickTrackingParsingContextDelegate {
    public func clickTrackingParsingContext(
        _ parsingContext: VAST.Parsing.ClickTrackingParsingContext,
        didParse parsedContent: VAST.Element.ClickTracking
    ) {
        guard currentParsingContext === parsingContext else { return }
        if let element = parsedContent as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}
