extension VAST.Parsing.AnyElementParser: AdSystemParsingContextDelegate {
    public func adSystemParsingContext(
        _ parsingContext: VAST.Parsing.AdSystemParsingContext,
        didParse parsedContent: VAST.Element.AdSystem
    ) {
        guard currentParsingContext === parsingContext else { return }
        if let element = parsedContent as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}
