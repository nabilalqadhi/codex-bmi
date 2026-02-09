import Combine
import SwiftUI

final class BMIViewModel: ObservableObject {
    enum HeightUnit: String, CaseIterable, Identifiable {
        case centimeters = "cm"
        case meters = "m"

        var id: String { rawValue }
    }

    @Published var weightText: String = ""
    @Published var heightText: String = ""
    @Published var heightUnit: HeightUnit = .centimeters
    @Published var selectedGender: String = ""
    @Published var ageText: String = ""
    @Published private(set) var result: BMIResult?
    @Published var showResult: Bool = false

    let genderOptions = ["", "Female", "Male", "Non-binary", "Prefer not to say"]

    var isInputValid: Bool {
        guard let weight = Double(weightText), weight > 0,
              let height = Double(heightText), height > 0 else {
            return false
        }
        return true
    }

    func calculateBMI() {
        guard isInputValid,
              let weight = Double(weightText),
              let heightValue = Double(heightText) else {
            return
        }

        let heightMeters = heightUnit == .centimeters ? heightValue / 100.0 : heightValue
        let bmiValue = weight / (heightMeters * heightMeters)
        let category = BMICategory.category(for: bmiValue)
        result = BMIResult(value: bmiValue, category: category)

        withAnimation(.easeInOut) {
            showResult = true
        }
    }

    func reset() {
        withAnimation(.easeInOut) {
            showResult = false
        }
    }
}
