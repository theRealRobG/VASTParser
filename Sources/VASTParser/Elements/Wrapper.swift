public extension VAST.Element {
    /// VAST Wrappers are used to redirect the media player to another server for either an additional `<Wrapper>` or
    /// the VAST `<InLine>` ad. In addition to the URI that points to another file, the Wrapper may contain tracking
    /// elements that provide tracking for the InLine ad that is served following one or more wrappers. A Wrapper may
    /// also contain `<Companion>` creative and `<Icon>` creative. And while `<Linear>` and `<NonLinear>` elements are
    /// available in the Wrapper, they are only used for tracking. No media files are provided for Linear elements, nor
    /// are resource files provided for NonLinear elements. Other elements offered for InLine ads may not be offered for
    /// Wrappers.
    struct Wrapper {
        /// The ad server provides an impression-tracking URI for either the InLine ad or the Wrapper
        /// using the `<Impression>` element. All `<Impression>` URIs in the InLine response and any
        /// Wrapper responses preceding it should be triggered at the same time when the impression
        /// for the ad occurs, or as close in time as possible to when the impression occurs, to prevent
        /// impression-counting discrepancies.
        public let impression: [Impression]
        /// A URI to a VAST response that may be another VAST Wrapper or a VAST InLine ad. The number of VAST wrappers
        /// should not exceed 5 before an InLine ad is served. After 5 VAST wrapper responses, acceptance of additional
        /// VAST responses is at the publisher’s discretion.
        ///
        /// While VAST Wrappers don’t provide all the same elements offered for an InLine ad, the `<VASTAdTagURI>` is
        /// the only element that is unique to Wrappers. The VASTAdTagURI is used to provide a URI to a secondary VAST
        /// response. This secondary response may be another Wrapper, but eventually a VAST wrapper must return an
        /// `<InLine>` ad. In VAST 4 the player is only required to accept five wrappers ads. If no InLine ads are
        /// returned after 5 Wrappers, the player may move on to the next option.
        public let vastAdTagURI: VASTAdTagURI
        /// Ad categories are used in creative separation and for compliance in certain programs. In a wrapper, this
        /// field defines ad categories that cannot be returned by a downstream ad server. This value is used to
        /// populate the `[BLOCKEDADCATEGORIES]` request macro in VASTAdTagURI strings, and can also be used by the
        /// player to reject InLine ads with Category fields that violate the BlockedAdCategories fields of upstream
        /// wrappers. If an InLine ad is skipped due to a category violation, the client must notify the ad server using
        /// the `<Error>` URI, if provided (error code 205), and move on to the next option.
        public let blockedAdCategories: [BlockedAdCategories]
        /// A Boolean value that identifies whether subsequent Wrappers after a requested VAST response is allowed. If
        /// false, any Wrappers received (i.e. not an Inline VAST response) should be ignored. Otherwise, VAST Wrappers
        /// received should be accepted (default value is “true.”)
        public let followAdditionalWrappers: Bool
        /// A Boolean value that indicates whether multiple ads are allowed in the requested VAST response. If true,
        /// both Pods and stand-alone ads are allowed. If false, only the first stand-alone Ad (with no sequence values)
        /// in the requested VAST response is allowed. Default value is “false.”
        public let allowMultipleAds: Bool
        /// The ad serving party must provide a descriptive name for the system that serves the ad. Optionally,
        /// a version number for the ad system may also be provided using the version attribute.
        public let adSystem: AdSystem?
        /// Used to provide a value that represents a price that can be used by real-time bidding (RTB)
        /// systems. VAST is not designed to handle RTB since other methods exist, but this element is offered
        /// for custom solutions if needed. If the value provided is to be obfuscated or encoded, publishers and
        /// advertisers must negotiate the appropriate mechanism to do so.
        /// When included as part of a VAST Wrapper in a chain of Wrappers, only the value offered in the first
        /// Wrapper need be considered.
        public let pricing: Pricing?
        /// A URI supplied by the ad server and used to report the no ad response.
        ///
        /// The `<Error>` element contains a URI that the player uses to notify the ad server when errors occur with ad
        /// playback. If the URI contains an `[ERRORCODE]` macro, the media player must populate the macro with an error
        /// code as defined in section 2.3.6 of VAST 4.2.
        ///
        /// If no specific error can be found, error 900 may be used to indicate an undefined error; however, every
        /// attempt should be made to provide an error code that maps to the error that occurred. The `<Error>` element
        /// is available for both the InLine or Wrapper elements.
        public let error: Error?
        /// The ad server may provide URIs for tracking publisher-determined viewability, for both the InLine ad
        /// and any Wrappers, using the `<ViewableImpression>` element. Tracking URIs may be
        /// provided in three containers: `<Viewable>`, `<NotViewable>`, and
        /// `<ViewUndetermined>`.
        ///
        /// The point at which these tracking resource files are pinged depends on the viewability standard the
        /// player has implemented, in agreement with or with the understanding of the buyer.
        ///
        /// Player support for the `<ViewableImpression>` element is optional. When used, URIs for the
        /// Inline ad as well as any wrappers used to serve the ad should all be triggered at the same time, or
        /// as close in time as possible to when the criteria for the individual event is met.
        ///
        /// Note – ViewableImpression is not applicable for Audio use cases.
        public let viewableImpression: ViewableImpression?
        /// The `<AdVerifications>` element contains one or more `<Verification>` elements,
        /// which list the resources and metadata required to execute third-party measurement code in
        /// order to verify creative playback.The `<AdVerifications>` element is used to contain one
        /// or more `<Verification>` elements, which are used to initiate a controlled container
        /// where code can be executed for collecting data to verify ad playback details.
        public let adVerifications: AdVerifications?
        /// Ad servers can use this XML node for custom extensions of VAST. When used, custom XML
        /// should fall under the nested `<Extension>` (singular) element so that custom XML can be
        /// separated from VAST elements. An XML namespace (xmlns) should also be used for the
        /// custom extension to separate it from VAST components.
        public let extensions: Extensions?
        /// The `<Creatives>` (plural) element is a container for one or more `<Creative>` (singular)
        /// element used to provide creative files for the ad. For an InLine ad, the `<Creatives>` element
        /// nests all the files necessary for executing and tracking the ad.
        ///
        /// In a Wrapper, elements nested under `<Creatives>` are used mostly for tracking. Companion
        /// and Icon creative may be included in a Wrapper, but files for Linear and NonLinear ads can only be
        /// provided in the InLine version of the ad.
        public let creatives: Creatives?
        /// A Boolean value that provides instruction for using an available Ad when the requested VAST response returns
        /// no ads. If true, the media player should select from any stand-alone ads available. If false and the Wrapper
        /// represents an Ad in a Pod, the media player should move on to the next Ad in a Pod; otherwise, the media
        /// player can follow through at its own discretion where no-ad responses are concerned.
        public let fallbackOnNoAd: Bool?

        public init(
            impression: [Impression],
            vastAdTagURI: VASTAdTagURI,
            blockedAdCategories: [BlockedAdCategories],
            followAdditionalWrappers: Bool = true,
            allowMultipleAds: Bool = false,
            adSystem: AdSystem?,
            pricing: Pricing?,
            error: Error?,
            viewableImpression: ViewableImpression?,
            adVerifications: AdVerifications?,
            extensions: Extensions?,
            creatives: Creatives?,
            fallbackOnNoAd: Bool?
        ) {
            self.impression = impression
            self.vastAdTagURI = vastAdTagURI
            self.blockedAdCategories = blockedAdCategories
            self.followAdditionalWrappers = followAdditionalWrappers
            self.allowMultipleAds = allowMultipleAds
            self.adSystem = adSystem
            self.pricing = pricing
            self.error = error
            self.viewableImpression = viewableImpression
            self.adVerifications = adVerifications
            self.extensions = extensions
            self.creatives = creatives
            self.fallbackOnNoAd = fallbackOnNoAd
        }
    }
}
