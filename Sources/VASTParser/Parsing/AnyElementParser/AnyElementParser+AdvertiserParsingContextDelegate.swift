extension VAST.Parsing.AnyElementParser: AdvertiserParsingContextDelegate {
    public func advertiserParsingContext(
        _ parsingContext: VAST.Parsing.AdvertiserParsingContext,
        parsedContent: VAST.Element.Advertiser
    ) {
        guard parsingContext === currentParsingContext else { return }
        if let element = parsedContent as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}
