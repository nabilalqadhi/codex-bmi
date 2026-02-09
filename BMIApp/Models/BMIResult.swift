import Foundation

struct BMIResult {
    let value: Double
    let category: BMICategory

    var formattedValue: String {
        String(format: "%.1f", value)
    }
}
