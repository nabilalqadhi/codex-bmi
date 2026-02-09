import SwiftUI

struct ResultView: View {
    @ObservedObject var viewModel: BMIViewModel

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            resultCard
            tipsButton
            Spacer()
            resetButton
        }
        .padding()
        .navigationTitle("Your Result")
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }

    private var resultCard: some View {
        VStack(spacing: 12) {
            Text("BMI")
                .font(.headline)
                .foregroundColor(.secondary)
            Text(viewModel.result?.formattedValue ?? "--")
                .font(.system(size: 56, weight: .bold))
                .accessibilityLabel("Your BMI is \(viewModel.result?.formattedValue ?? "not available")")
            Text(viewModel.result?.category.name ?? "")
                .font(.title2.weight(.semibold))
            Text(viewModel.result?.category.description ?? "")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(18)
        .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 8)
        .accessibilityElement(children: .combine)
    }

    private var tipsButton: some View {
        NavigationLink(destination: TipsView(viewModel: viewModel)) {
            Text("See Health Tips")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(14)
        }
    }

    private var resetButton: some View {
        Button(action: viewModel.reset) {
            Text("Recalculate")
                .font(.body.weight(.medium))
                .foregroundColor(.accentColor)
        }
        .padding(.bottom)
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = BMIViewModel()
        viewModel.weightText = "70"
        viewModel.heightText = "175"
        viewModel.calculateBMI()
        return NavigationView {
            ResultView(viewModel: viewModel)
        }
    }
}
