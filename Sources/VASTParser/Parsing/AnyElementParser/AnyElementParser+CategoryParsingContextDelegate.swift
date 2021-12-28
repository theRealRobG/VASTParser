extension VAST.Parsing.AnyElementParser: CategoryParsingContextDelegate {
    public func categoryParsingContext(
        _ parsingContext: VAST.Parsing.CategoryParsingContext,
        didParse parsedContent: VAST.Element.Category
    ) {
        guard currentParsingContext === parsingContext else { return }
        if let element = parsedContent as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}
