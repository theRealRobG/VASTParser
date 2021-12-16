public extension VAST.Element {
    /// Some ad serving systems may want to send data to the media file when first initialized. For example, the
    /// media file may use ad server data to identify the context used to display the creative, what server to talk
    /// to, or even which creative to display. The optional `<AdParameters>` element for the Linear creative enables
    /// this data exchange.
    ///
    /// The optional attribute `xmlEncoded` is available for the `<AdParameters>` element to identify whether the ad
    /// parameters are xml-encoded. If true, the media player can only decode the data using XML. Media players
    /// operating on earlier versions of VAST may not be able to XML-decode data, so data should only be xml-encoded
    /// when being served to media players capable of XML-decoding the data.
    ///
    /// When a VAST response is used to serve a VPAID ad unit, the `<AdParameters>` element is currently the only
    /// way to pass information from the VAST response into the VPAID object; no other mechanism is provided.
    struct AdParameters {
        /// Metadata for the ad.
        public let content: String
        /// Identifies whether the ad parameters are xml-encoded.
        public let xmlEncoded: Bool

        public init(content: String, xmlEncoded: Bool) {
            self.content = content
            self.xmlEncoded = xmlEncoded
        }
    }
}
