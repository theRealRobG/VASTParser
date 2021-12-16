public extension VAST.Element {
    /// A reference to a non-JavaScript or custom-integration resource intended for collecting verification data via
    /// the listed apiFramework.
    struct ExecutableResource {
        /// A CDATA-wrapped reference to the resource. This may be a URI, but depending on the execution environment can
        /// be any value which enables the player to load the required verification code.
        public let content: String
        /// The name of the API framework used to execute the AdVerification code
        public let apiFramework: String
        /// The type of executable resource provided. The exact value used should be agreed upon by verification
        /// integrators and vendors who are implementing verification in a custom environment.
        public let type: String

        public init(content: String, apiFramework: String, type: String) {
            self.content = content
            self.apiFramework = apiFramework
            self.type = type
        }
    }
}
