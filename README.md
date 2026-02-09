# BMI Calculator (iOS)

## Overview
This project outlines a professional, iPhone X+ friendly BMI calculator that follows Apple Human Interface Guidelines and WHO BMI category ranges. The implementation uses SwiftUI with an MVVM architecture to keep UI and logic cleanly separated, while supporting Dynamic Type, VoiceOver, and safe-area aware layouts.

## Architecture (MVVM)
- **Models**: `BMICategory` and `BMIResult` store WHO ranges and display data.
- **ViewModel**: `BMIViewModel` manages input state, validation, BMI calculations, and navigation flow.
- **Views**: `ContentView` (input), `ResultView`, and `TipsView` handle the screen flow with minimal, health-focused styling.

```
BMIApp
├── Models
│   ├── BMICategory.swift
│   └── BMIResult.swift
├── ViewModels
│   └── BMIViewModel.swift
├── Views
│   ├── ContentView.swift
│   ├── ResultView.swift
│   └── TipsView.swift
└── BMIAppApp.swift
```

## Screen Flow
1. **Input**: Weight (kg), height (cm/m), optional gender and age. Validation enables the calculate button.
2. **Result**: Displays BMI value, category, and a short explanation.
3. **Tips**: Offers category-aligned, user-friendly guidance and a medical disclaimer.

## UI/UX Highlights
- Safe-area aware layout optimized for iPhone X+.
- Minimal, health-focused colors using system backgrounds and accent colors.
- Dynamic Type support via system font styles.
- VoiceOver-friendly labels and grouped accessibility elements.
- Smooth transition animation when presenting results.

## BMI Formula
```
BMI = weight / (height × height)
```

## Sample SwiftUI Code
### BMI Calculation (ViewModel)
```swift
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
```

### Result Presentation (SwiftUI)
```swift
Text(viewModel.result?.formattedValue ?? "--")
    .font(.system(size: 56, weight: .bold))

Text(viewModel.result?.category.name ?? "")
    .font(.title2.weight(.semibold))
```

## Scalability for Future Features
- Add a **History** model and persistent storage (Core Data or SwiftData).
- Introduce **Charts** using Swift Charts (iOS 16+) with a fallback in iOS 13+.
- Expand personalization with **profile settings** and **trend tracking**.
- Integrate **HealthKit** for optional weight/height data syncing.

## Medical Disclaimer
BMI is a screening tool and does not diagnose health conditions. The app is for informational purposes only and does not replace professional medical advice.
