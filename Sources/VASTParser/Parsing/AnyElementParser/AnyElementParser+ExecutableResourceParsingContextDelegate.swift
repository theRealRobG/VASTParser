extension VAST.Parsing.AnyElementParser: ExecutableResourceParsingContextDelegate {
    public func executableResourceParsingContext(
        _ parsingContext: VAST.Parsing.ExecutableResourceParsingContext,
        didParse parsedContent: VAST.Element.ExecutableResource
    ) {
        guard currentParsingContext === parsingContext else { return }
        if let element = parsedContent as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}
