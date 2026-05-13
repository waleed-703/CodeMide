import SwiftUI

struct AnswerScreen: View {

    @Environment(\.dismiss) var dismiss

    @StateObject private var viewModel = QuestionViewModel()
    @StateObject private var streammodel = EEGViewModel()
    @StateObject private var bpviewmodel = BPViewModel()

    private let teal = Color(
        red: 0.36,
        green: 0.85,
        blue: 0.93
    )

    @Binding var selectedtab : Int

    let question : Question

    @Binding var answer : String

    @Binding var chatgpt : Bool

    @State private var stoprecording = false

    @State private var showalert = false
    @State private var alertmessage = ""

    let sessionid: Int
    let questioncount : Int

    @State private var timeremaining : Int = 0
    @State private var timer : Timer?

    @State private var showMidBPSheet = false

    @State private var midBPResult: EndBP? = nil

    @State private var midBPWorkItem: DispatchWorkItem?

    @State private var hasNavigated = false

    // ✅ NEW
    @State private var isScreenActive = false

    var body: some View {

        ZStack {

            teal.ignoresSafeArea()

            VStack {

                HStack {

                    Button(action: {

                        streammodel.ResetAll()

                        streammodel.deleteSession(
                            sessionID: sessionid
                        )

                        cleanupTimer()

                        selectedtab = max(
                            0,
                            selectedtab - 1
                        )

                    }) {

                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.white)
                    }

                    Spacer()

                    Image("codemide")
                        .resizable()
                        .frame(width:100, height: 100)

                    Spacer()
                }
                .padding(.horizontal)

                VStack(alignment:.leading){

                    ScrollView {

                        VStack(alignment: .leading){

                            Text("Question Statement:")

                            Text(question.description)
                                .foregroundStyle(.white)

                            HStack {

                                Image(systemName: "clock")
                                    .font(.title2)

                                Text(
                                    formatTime(timeremaining)
                                )
                                .font(.title2)

                            }
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background(
                                Color.white.opacity(0.6)
                            )
                            .clipShape(Capsule())
                            .frame(maxWidth: .infinity)

                        }
                        .padding(20)
                        .frame(
                            maxWidth: .infinity,
                            alignment: .leading
                        )
                        .background(teal)
                        .cornerRadius(12)

                        // ✅ FIXED
                        .onAppear {

                            isScreenActive = true

                            resetQuestionState()
                        }

                        // ✅ FIXED
                        .onDisappear {

                            isScreenActive = false

                            cleanupTimer()
                        }

                        .onChange(of: question.qid) { _ in

                            resetQuestionState()
                        }

                        VStack(alignment: .leading){

                            HStack {

                                Text("Answer:")
                                    .foregroundStyle(teal)
                                    .font(.headline)

                                Spacer()

                                Toggle(isOn: $chatgpt){

                                    Text("ChatGPT")
                                        .foregroundStyle(teal)
                                        .fontWeight(.semibold)
                                }
                                .fixedSize()
                            }
                            .padding(.horizontal,6)

                            VStack {

                                TextEditor(text: $answer)
                                    .padding(10)
                                    .autocapitalization(.none)
                                    .frame(height:300)

                            }
                            .background(Color.white)
                            .cornerRadius(12)
                        }

                        HStack {

                            Button {

                                recordingstop()

                            } label: {

                                if stoprecording {

                                    ProgressView()
                                        .tint(.white)

                                } else {

                                    Text("Next")
                                }
                            }
                            .frame(maxWidth: 150)
                            .padding()
                            .background(teal)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .disabled(stoprecording)
                        }
                        .padding(20)

                        Text("Auto sumbits when time ends")
                            .font(.caption)
                            .foregroundStyle(Color.gray)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                    .padding(.horizontal, 12)
                }
            }
        }

        .alert(
            "Connection Error!",
            isPresented: $showalert
        ){

            Button(
                "OK",
                role: .cancel
            ){}

        } message: {

            Text(alertmessage)
        }

        .onChange(of: streammodel.errorMessage){ error in

            if let error = error {

                stoprecording = false

                alertmessage = error

                showalert = true
            }
        }

        .onChange(of: bpviewmodel.isMidBPLoading) { loading in

            if !loading,
               let last = bpviewmodel.history.last {

                midBPResult = last.1
            }
        }

        .sheet(isPresented: $showMidBPSheet) {

            MidBPSheet(
                viewModel: bpviewmodel,
                result: $midBPResult,
                isPresented: $showMidBPSheet
            )
            .presentationDetents([.height(320)])
            .presentationDragIndicator(.visible)
        }

        .navigationBarBackButtonHidden(true)
    }

    // ✅ STOP RECORDING
    func recordingstop(){

        guard !stoprecording else { return }

        stoprecording = true

        cleanupTimer()

        streammodel.errorMessage = nil

        print("Stopping recording...")

        streammodel.stoprecording(
            answers: answer,
            gptIndex: chatgpt ? 1 : 0
        )

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 1.0
        ){

            stoprecording = false

            selectedtab = 4
        }
    }

    // ✅ TIMER
    func startTimer() {

        timer?.invalidate()

        timer = Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ) { _ in

            if timeremaining > 0 {

                timeremaining -= 1

            } else {

                timer?.invalidate()
                timer = nil

                recordingstop()
            }
        }

        RunLoop.current.add(
            timer!,
            forMode: .common
        )
    }

    // ✅ RESET QUESTION
    func resetQuestionState() {

        timer?.invalidate()
        timer = nil

        hasNavigated = false

        showMidBPSheet = false

        timeremaining = question.duration * 60

        startTimer()

        midBPWorkItem?.cancel()

        let workItem = DispatchWorkItem {

            DispatchQueue.main.async {

                // ✅ IMPORTANT FIX
                if isScreenActive &&
                    !hasNavigated {

                    showMidBPSheet = true
                }
            }
        }

        midBPWorkItem = workItem

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 30,
            execute: workItem
        )
    }

    // ✅ CLEANUP
    func cleanupTimer() {

        timer?.invalidate()
        timer = nil

        midBPWorkItem?.cancel()
        midBPWorkItem = nil

        showMidBPSheet = false

        hasNavigated = true
    }

    // ✅ FORMAT TIMER
    func formatTime(_ seconds: Int) -> String {

        let minutes = seconds / 60

        let seconds = seconds % 60

        return String(
            format: "%02d:%02d",
            minutes,
            seconds
        )
    }
}

#Preview {

    AnswerScreen(
        selectedtab: .constant(0),
        question: .init(
            qid: 0,
            description: "",
            duration: 0,
            questionlevel: "",
            count: 0
        ),
        answer: .constant(""),
        chatgpt: .constant(false),
        sessionid: 0,
        questioncount: 0
    )
}
