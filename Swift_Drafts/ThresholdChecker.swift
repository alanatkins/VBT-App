import Foundation

// This struct maps training goals to target velocity ranges
struct ThresholdChecker {
    static let velocityZones: [String: ClosedRange<Double>] = [
        "Max Strength": 0.15...0.35,
        "Strength-Speed": 0.45...0.75,
        "Speed-Strength": 0.75...1.0,
        "Explosiveness": 1.0...1.3
    ]
    
    static func isWithinTarget(for trainingType: String, velocity: Double) -> Bool {
        if let range = velocityZones[trainingType] {
            return range.contains(velocity)
        }
        return false
    }
    
    static func getTargetRangeText(for trainingType: String) -> String {
        if let range = velocityZones[trainingType] {
            return String(format: "%.2f – %.2f m/s", range.lowerBound, range.upperBound)
        }
        return "N/A"
    }
}
// This struct is used to check if the velocity is within the target range for a given training type