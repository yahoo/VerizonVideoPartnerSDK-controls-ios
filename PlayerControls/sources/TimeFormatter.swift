//  Copyright © 2017 Oath. All rights reserved.
/// Current time of played video.
public enum CurrentTimeControl {}

public enum TimeFormatter {
    static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 2
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    public static func string(from value: Int) -> String {
        let hours = value / 3600
        let minutes = value / 60 % 60
        let seconds = value % 60
        
        func format(_ value: Int) -> String {
            guard let string = formatter.string(from: NSNumber(value: value)) else {
                fatalError("Unhandled conversion!")
            }
            return string
        }
        
        if hours > 0 {
            return "\(hours):\(format(minutes)):\(format(seconds))"
        } else {
            return "\(minutes):\(format(seconds))"
        }
    }
}
