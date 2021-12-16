public extension VAST.Element {
    /// Each `<Creative>` element contains nested elements that describe the type of ad being served
    /// using nested sub-elements. Multiple creatives may be used to define different components of the
    /// ad. At least one `<Linear>` element is required under the Creative element.
    struct Creative {
        /// A required element for the purpose of tracking ad creative, the `<UniversalAdId>` is used
        /// to provide a unique creative identifier that is maintained across systems. This creative ID may
        /// be generated with an authoritative program, such as the AD-ID® program in the United States,
        /// or Clearcast in the UK. Some countries may have specific requirements for ad- tracking
        /// programs.
        ///
        /// Note: A creative id can also be included in the adId attribute used in the `<Creative>`
        /// element, but that creative id should be used to specify the ad server’s unique identifier.
        /// The UniversalAdId is used for maintaining a creative id for the ad across multiple systems.
        public let universalAdId: [UniversalAdId]
        /// A string used to identify the ad server that provides the creative.
        public let id: String?
        /// Used to provide the ad server’s unique identifier for the creative. In VAST 4, the UniversalAdId
        /// element was introduced to provide a unique identifier for the creative that is maintained across
        /// systems.
        public let adId: String?
        /// A number representing the numerical order in which each sequenced creative within an ad
        /// should play.
        public let sequence: Int?
        /// A string that identifies an API that is needed to execute the creative.
        public let apiFramework: String?
        /// When an executable file is needed as part of the creative delivery or execution, a
        /// `<CreativeExtensions>` element can be added under the `<Creative>`. This
        /// extension can be used to load an executable creative with or without using the
        /// `<MediaFile>`.
        ///
        /// A `<CreativeExtension>` (singular) element is nested under the
        /// `<CreativeExtensions>` (plural) element so that any XML extensions are separated
        /// from VAST XML. Additionally, any XML used in this extension should identify an XML name
        /// space (xmlns) to avoid confusing any of the extension element names with those of VAST.
        ///
        /// The nested `<CreativeExtension>` includes an attribute for type, which specifies the
        /// MIME type needed to execute the extension.
        public let creativeExtensions: CreativeExtensions?
        /// Linear Ads are the video or audio formatted ads that play linearly within the streaming content,
        /// meaning before the streaming content, during a break, or after the streaming content. A Linear
        /// creative contains a `<Duration>` element to communicate the intended runtime and a
        /// `<MediaFiles>` element used to provide the needed video or audio files for ad execution.
        public let linear: Linear?
        /// Companion Ads are secondary ads included in the VAST tag that accompany the video/audio
        /// ad. The `<CompanionAds>` element is a container for one or more `<Companion>`
        /// elements, where each Companion element provides the creative files and tracking details.
        /// Companion Ads, including any creative, may be included in both InLine and Wrapper
        /// formatted VAST ads.
        public let companionAds: CompanionAds?
        /// NonLinear ads are the overlay ads that display as an image or rich media on top of video content during
        /// playback. Within an InLine ad, at least one of `<Linear>` or `<NonLinearAds>` needs to be provided within
        /// the `<Creative>` element.
        ///
        /// NonLinearAds are not applicable to Audio use cases.
        ///
        /// The `<NonLinearAds>` element is a container for the `<NonLinear>` creative files and tracking resources. If
        /// used in a wrapper, only the tracking elements are available. NonLinear creative cannot be provided in a
        /// wrapper ad.
        public let nonLinearAds: NonLinearAds?

        public init(
            universalAdId: [UniversalAdId],
            id: String?,
            adId: String?,
            sequence: Int?,
            apiFramework: String?,
            creativeExtensions: CreativeExtensions?,
            linear: Linear?,
            companionAds: CompanionAds?,
            nonLinearAds: NonLinearAds?
        ) {
            self.universalAdId = universalAdId
            self.id = id
            self.adId = adId
            self.sequence = sequence
            self.apiFramework = apiFramework
            self.creativeExtensions = creativeExtensions
            self.linear = linear
            self.companionAds = companionAds
            self.nonLinearAds = nonLinearAds
        }
    }
}
