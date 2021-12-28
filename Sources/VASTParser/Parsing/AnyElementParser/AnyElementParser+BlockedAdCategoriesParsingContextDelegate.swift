extension VAST.Parsing.AnyElementParser: BlockedAdCategoriesParsingContextDelegate {
    public func blockedAdCategoriesParsingContext(
        _ parsingContext: VAST.Parsing.BlockedAdCategoriesParsingContext,
        didParse parsedContent: VAST.Element.BlockedAdCategories
    ) {
        guard currentParsingContext === parsingContext else { return }
        if let element = parsedContent as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}
