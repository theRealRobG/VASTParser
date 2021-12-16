import Foundation

public struct DurationString: ExpressibleByStringLiteral, CustomStringConvertible {
    public var description: String
    public var seconds: Double? {
        let components = description.split(separator: ":")
        guard components.count == 3 else { return nil }
        guard
            let hours = Double(components[0]),
            let minutes = Double(components[1]),
            let seconds = Double(components[2])
        else {
            return nil
        }
        return (hours * 3600) + (minutes * 60) + seconds
    }

    public init(stringLiteral value: StringLiteralType) {
        self.description = value
    }

    public init(seconds: Double) {
        let isNegative = seconds < 0
        let secondsPerMinute = 60
        let minutesPerHour = 60
        let secondsPerHour = secondsPerMinute * minutesPerHour
        let absoluteSelf = abs(seconds)
        let hours = Int(absoluteSelf) / secondsPerHour
        let minutes = Int(absoluteSelf) / secondsPerMinute % minutesPerHour
        let seconds = Int(absoluteSelf) % secondsPerMinute
        let milliseconds = abs(floor(absoluteSelf) - absoluteSelf)
        var description = String(format: "\(isNegative ? "-" : "")%02i:%02i:%02i", hours, minutes, seconds)
        if milliseconds > 0 {
            description += ".\(Int(round(milliseconds * 1000)))"
        }
        self.description = description
    }
}
