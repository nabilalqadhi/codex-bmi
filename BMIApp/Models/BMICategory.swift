import Foundation

struct BMICategory: Identifiable {
    let id = UUID()
    let name: String
    let range: ClosedRange<Double>
    let description: String
    let recommendation: String

    static let all: [BMICategory] = [
        BMICategory(
            name: "Underweight",
            range: 0...18.4,
            description: "Your BMI is below the recommended range.",
            recommendation: "Consider a balanced nutrition plan and discuss goals with a clinician."
        ),
        BMICategory(
            name: "Normal",
            range: 18.5...24.9,
            description: "Your BMI is within the recommended range.",
            recommendation: "Keep up healthy activity, nutrition, and sleep habits."
        ),
        BMICategory(
            name: "Overweight",
            range: 25.0...29.9,
            description: "Your BMI is above the recommended range.",
            recommendation: "Small, sustainable changes in movement and nutrition can help."
        ),
        BMICategory(
            name: "Obese",
            range: 30.0...60.0,
            description: "Your BMI is significantly above the recommended range.",
            recommendation: "Consider professional guidance for a personalized health plan."
        )
    ]

    static func category(for bmi: Double) -> BMICategory {
        BMICategory.all.first(where: { $0.range.contains(bmi) }) ?? BMICategory.all.last!
    }
}
