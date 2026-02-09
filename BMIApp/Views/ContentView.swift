import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = BMIViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    header
                    inputCard
                    calculateButton
                    disclaimer
                }
                .padding()
            }
            .navigationTitle("BMI Calculator")
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .overlay(resultNavigationLink)
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Track your body mass index")
                .font(.title2.weight(.semibold))
                .accessibilityAddTraits(.isHeader)
            Text("Enter your details to calculate a WHO-aligned BMI range.")
                .font(.body)
                .foregroundColor(.secondary)
        }
    }

    private var inputCard: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                TextField("Weight (kg)", text: $viewModel.weightText)
                    .keyboardType(.decimalPad)
                    .textContentType(.none)
                    .font(.title3.weight(.medium))
                    .accessibilityLabel("Weight in kilograms")

                Divider()

                TextField("Height", text: $viewModel.heightText)
                    .keyboardType(.decimalPad)
                    .textContentType(.none)
                    .font(.title3.weight(.medium))
                    .accessibilityLabel("Height value")

                Picker("Height unit", selection: $viewModel.heightUnit) {
                    ForEach(BMIViewModel.HeightUnit.allCases) { unit in
                        Text(unit.rawValue)
                            .tag(unit)
                    }
                }
                .pickerStyle(.menu)
                .accessibilityLabel("Height unit")
            }

            Divider()

            HStack(spacing: 12) {
                Picker("Gender", selection: $viewModel.selectedGender) {
                    ForEach(viewModel.genderOptions, id: \.self) { option in
                        Text(option.isEmpty ? "Gender (optional)" : option)
                            .tag(option)
                    }
                }
                .pickerStyle(.menu)
                .accessibilityLabel("Gender")

                Divider()

                TextField("Age (optional)", text: $viewModel.ageText)
                    .keyboardType(.numberPad)
                    .textContentType(.none)
                    .font(.body)
                    .accessibilityLabel("Age")
            }
        }
        .padding()
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.06), radius: 10, x: 0, y: 6)
        .accessibilityElement(children: .contain)
    }

    private var calculateButton: some View {
        Button(action: viewModel.calculateBMI) {
            HStack {
                Spacer()
                Text("Calculate BMI")
                    .font(.headline)
                Spacer()
            }
            .padding()
            .background(viewModel.isInputValid ? Color.accentColor : Color.gray.opacity(0.4))
            .foregroundColor(.white)
            .cornerRadius(14)
        }
        .disabled(!viewModel.isInputValid)
        .accessibilityHint("Calculates your body mass index")
    }

    private var disclaimer: some View {
        Text("BMI is a screening tool and does not diagnose health conditions. Consult a clinician for medical advice.")
            .font(.footnote)
            .foregroundColor(.secondary)
            .accessibilityLabel("Medical disclaimer")
    }

    private var resultNavigationLink: some View {
        NavigationLink(
            destination: ResultView(viewModel: viewModel),
            isActive: $viewModel.showResult
        ) {
            EmptyView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
