public extension VAST.Element {
    /// The `<AdVerifications>` element contains one or more `<Verification>` elements,
    /// which list the resources and metadata required to execute third-party measurement code in
    /// order to verify creative playback.The `<AdVerifications>` element is used to contain one
    /// or more `<Verification>` elements, which are used to initiate a controlled container
    /// where code can be executed for collecting data to verify ad playback details.
    ///
    /// The `<Verification>` element contains the executable and bootstrapping data required to run the measurement
    /// code for a single verification vendor. Multiple `<Verification>` elements may be listed, in order to support
    /// multiple vendors, or if multiple API frameworks are supported. At least one `<JavaScriptResource>` or
    /// `<ExecutableResource>` should be provided. At most one of these resources should selected for execution, as
    /// best matches the technology available in the current environment.
    ///
    /// If the player is willing and able to run one of these resources, it should execute them BEFORE creative
    /// playback begins. Otherwise, if no resource can be executed, any appropriate tracking events listed under the
    /// `<Verification>` element must be fired.
    typealias AdVerifications = [Verification]
}
