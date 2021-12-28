extension VAST.Parsing.AnyElementParser: JavaScriptResourceParsingContextDelegate {
    public func javaScriptResourceParsingContext(
        _ parsingContext: VAST.Parsing.JavaScriptResourceParsingContext,
        didParse parsedContent: VAST.Element.JavaScriptResource
    ) {
        guard currentParsingContext === parsingContext else { return }
        if let element = parsedContent as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}
