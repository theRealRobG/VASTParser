import Foundation

enum VASTParsingError: CustomNSError {
    case unexpectedStartOfElement(parentElementName: String, unexpectedElementName: String)
    case unexpectedEndOfElement(parentElementName: String, unexpectedElementName: String)
    case missingRequiredProperty(parentElementName: String, missingPropertyName: String)

    static var errorDomain: String { "VASTParsingErrorDomain" }

    var errorCode: Int {
        switch self {
        case .unexpectedStartOfElement: return 100
        case .unexpectedEndOfElement: return 101
        case .missingRequiredProperty: return 102
        }
    }

    var errorUserInfo: [String: Any] {
        var userInfo = [String: Any]()
        switch self {
        case .unexpectedStartOfElement(let parentElementName, let unexpectedElementName):
            let m = "Unexpected start of element \(unexpectedElementName) found while parsing \(parentElementName)"
            userInfo[NSLocalizedDescriptionKey] = m
        case .unexpectedEndOfElement(let parentElementName, let unexpectedElementName):
            let m = "Unexpected end of element \(unexpectedElementName) found while parsing \(parentElementName)"
            userInfo[NSLocalizedDescriptionKey] = m
        case .missingRequiredProperty(let parentElementName, let missingPropertyName):
            let m = "Missing required \(missingPropertyName) while persing \(parentElementName)"
            userInfo[NSLocalizedDescriptionKey] = m
        }
        return userInfo
    }
}
