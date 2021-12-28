extension VAST.Parsing.AnyElementParser: AdParametersParsingContextDelegate {
    public func adParametersParsingContext(
        _ parsingContext: VAST.Parsing.AdParametersParsingContext,
        didParse adParameters: VAST.Element.AdParameters
    ) {
        guard currentParsingContext === parsingContext else { return }
        if let element = adParameters as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}
