extension VAST.Parsing.AnyElementParser: AdSystemParsingContextDelegate {
    public func adSystemParsingContext(
        _ parsingContext: VAST.Parsing.AdSystemParsingContext,
        didParse adSystem: VAST.Element.AdSystem
    ) {
        guard currentParsingContext === parsingContext else { return }
        if let element = adSystem as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}
