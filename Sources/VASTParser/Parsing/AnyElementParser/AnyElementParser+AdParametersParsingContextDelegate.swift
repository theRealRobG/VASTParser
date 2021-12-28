extension VAST.Parsing.AnyElementParser: AdParametersParsingContextDelegate {
    public func adParametersParsingContext(
        _ parsingContext: VAST.Parsing.AdParametersParsingContext,
        didParse parsedContent: VAST.Element.AdParameters
    ) {
        guard currentParsingContext === parsingContext else { return }
        if let element = parsedContent as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}
