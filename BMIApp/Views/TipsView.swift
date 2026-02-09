import SwiftUI

struct TipsView: View {
    @ObservedObject var viewModel: BMIViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Personalized Tips")
                .font(.title2.weight(.semibold))
            Text(viewModel.result?.category.recommendation ?? "Keep focusing on balanced habits.")
                .font(.body)
                .foregroundColor(.secondary)

            Divider()

            VStack(alignment: .leading, spacing: 12) {
                Label("Aim for at least 150 minutes of moderate activity weekly.", systemImage: "figure.walk")
                Label("Build meals with lean protein, fiber, and hydration.", systemImage: "leaf")
                Label("Prioritize consistent sleep and recovery.", systemImage: "bed.double")
            }
            .font(.body)

            Spacer()

            Text("These tips are educational and not a substitute for professional medical advice.")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
        .padding()
        .navigationTitle("Tips")
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
    }
}

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = BMIViewModel()
        viewModel.weightText = "70"
        viewModel.heightText = "175"
        viewModel.calculateBMI()
        return NavigationView {
            TipsView(viewModel: viewModel)
        }
    }
}
