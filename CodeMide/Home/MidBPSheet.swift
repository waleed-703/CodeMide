import SwiftUI

struct MidBPSheet: View {
    @ObservedObject var viewModel: BPViewModel
    @Binding var result: EndBP?
    @Binding var isPresented: Bool
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)

    var body: some View {
        VStack(spacing: 20) {
            // Handle / title
            Text("Mid-question blood pressure")
                .font(.headline)
                .padding(.top, 8)

            Text("Turn on the device, then tap the button below.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            // Results area — only visible after a successful reading
            if let bp = result {
                HStack(spacing: 16) {
                    BPTile(label: "SYS", value: "\(bp.SYS)", delta: bp.DeltaSYS)
                    BPTile(label: "DIA", value: "\(bp.DIA)", delta: bp.DeltaDIA)
                    BPTile(label: "Pulse", value: "\(bp.PULSE)", delta: bp.DeltaPulse)
                }
                .padding(.horizontal)
                .transition(.opacity.combined(with: .move(edge: .bottom)))
            }

            // Action button
            Button {
                result = nil                            // clear previous result
                viewModel.midbp()
            } label: {
                Group {
                    if viewModel.isMidBPLoading {
                        ProgressView().tint(.white)
                    } else {
                        Text(result == nil ? "Take mid BP" : "Retake")
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(teal)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .disabled(viewModel.isMidBPLoading)
            .padding(.horizontal)

            // Close — only enabled once a reading is done (or let them dismiss via drag)
            Button("Done") {
                isPresented = false
            }
            .foregroundStyle(result != nil ? teal : Color.secondary)
            .disabled(result == nil && !viewModel.isMidBPLoading == false)
            // allow close even without a reading so user isn't trapped:
            .disabled(false)

            Spacer()
        }
        .animation(.easeInOut, value: result != nil)
    }
}

// Small tile for one BP metric
private struct BPTile: View {
    let label: String
    let value: String
    let delta: Int

    var body: some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
            Text(value)
                .font(.title2.bold())
            HStack(spacing: 2) {
                Image(systemName: delta >= 0 ? "arrow.up" : "arrow.down")
                    .font(.caption2)
                Text("\(abs(delta))")
                    .font(.caption2)
            }
            .foregroundStyle(delta > 10 ? .red : (delta < -10 ? .blue : .secondary))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}
#Preview {

    MidBPSheet(
        viewModel: BPViewModel(),
        result: .constant(nil),
        isPresented: .constant(true)
    )
}
