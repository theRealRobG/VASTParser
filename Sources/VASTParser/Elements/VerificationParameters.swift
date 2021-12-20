public extension VAST.Element {
    /// CDATA-wrapped metadata string for the verification executable.
    ///
    /// `<VerificationParameters>` contains a CDATA-wrapped string intended for bootstrapping the verification code
    /// and providing metadata about the current impression. The format of the string is up to the individual vendor
    /// and should be passed along verbatim.
    typealias VerificationParameters = String
}
