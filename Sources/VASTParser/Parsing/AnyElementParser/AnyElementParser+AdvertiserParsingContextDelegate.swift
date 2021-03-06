extension VAST.Parsing.AnyElementParser: AdvertiserParsingContextDelegate {
    public func advertiserParsingContext(
        _ parsingContext: VAST.Parsing.AdvertiserParsingContext,
        didParse parsedContent: VAST.Element.Advertiser
    ) {
        guard currentParsingContext === parsingContext else { return }
        if let element = parsedContent as? T {
            self.element = element
        }
        currentParsingContext = nil
    }
}
