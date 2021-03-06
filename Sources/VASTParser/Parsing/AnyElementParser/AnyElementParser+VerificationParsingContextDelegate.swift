extension VAST.Parsing.AnyElementParser: VerificationParsingContextDelegate {
    public func verificationParsingContext(
        _ parsingContext: VAST.Parsing.VerificationParsingContext,
        didParse parsedContent: VAST.Element.Verification
    ) {
        guard currentParsingContext === parsingContext else { return }
        if let element = parsedContent as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}
