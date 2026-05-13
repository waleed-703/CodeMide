import SwiftUI

struct SelfReport: View {

    private let teal = Color(
        red: 0.36,
        green: 0.85,
        blue: 0.93
    )

    @StateObject private var viewModel = EEGViewModel()
    @StateObject private var reportmodel = ReportViewModel()

    @State private var mental: Double = 0.5
    @State private var effort: Double = 0.5
    @State private var frustration: Double = 0.5

    @State private var userresponce = ""

    @State private var responcealert = false

    @Environment(\.dismiss) var dismiss

    @State private var mainscreen = false

    let studentid: Int
    let sessionid: Int
//    @Binding var sessionid: Int

    @Binding var selectedtab: Int

    @State var report = false

    var body: some View {

        ZStack {

            teal.ignoresSafeArea()

            VStack {

                VStack(alignment: .leading) {

                    HStack {

                        Button(action: {

                            viewModel.ResetAll()

                            viewModel.deleteSession(
                                sessionID: sessionid
                            )

                            dismiss()

                        }) {

                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(.white)
                        }

                        Spacer()

                        Image("codemide")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)

                        Spacer()
                    }
                    .padding(.horizontal)

                    ScrollView {

                        VStack {

                            VStack(alignment: .leading) {

                                Text(
                                    "Coding Work Load & Stress\nAssessment"
                                )
                                .foregroundStyle(.white)
                                .font(.title2)
                                .fontWeight(.semibold)

                                Text(
                                    "Please Rate Your Experience During This Coding Task."
                                )
                                .foregroundStyle(.white)
                                .font(.body)
                                .fontWeight(.semibold)

                                Text(
                                    "There are no right or wrong answers."
                                )
                                .foregroundStyle(.white)
                                .font(.body)
                                .fontWeight(.semibold)

                            }
                            .padding(15)
                            .frame(
                                maxWidth: .infinity,
                                alignment: .leading
                            )
                            .background(teal)
                            .cornerRadius(12)
                            .padding(.horizontal,10)

                            VStack(alignment:.leading,spacing: 6){

                                Text("Mental Demand:")
                                    .foregroundStyle(teal)
                                    .font(.title2)
                                    .fontWeight(.semibold)

                                Text("Question:")
                                    .foregroundStyle(teal)

                                Text(
                                    "How Mentally Demanding Was This Coding Task?"
                                )

                                Text("Helper Text:")
                                    .foregroundStyle(teal)

                                Text(
                                    "Did The Task Required a lot of thinking note,concentration, or problem-solving?"
                                )

                                Text("\(Int(mental))")
                                    .font(.headline)
                                    .foregroundColor(.green)
                                    .padding(.bottom, 5)

                                Slider(
                                    value: $mental,
                                    in: 0...5
                                )
                                .tint(.green)

                            }
                            .padding(20)
                            .frame(
                                maxWidth: .infinity,
                                alignment: .leading
                            )
                            .background(.white)
                            .cornerRadius(12)
                            .padding(.horizontal,10)

                            VStack(alignment:.leading,spacing : 6){

                                Text("Effort:")
                                    .foregroundStyle(teal)
                                    .font(.title2)
                                    .fontWeight(.semibold)

                                Text("Question:")
                                    .foregroundStyle(teal)

                                Text(
                                    "How Much Effort did you put into completing this task?"
                                )

                                Text("Helper Text:")
                                    .foregroundStyle(teal)

                                Text(
                                    "How Hard You Have To Work To Achieve Your Performance?"
                                )

                                Text("\(Int(effort))")
                                    .font(.headline)
                                    .foregroundColor(.yellow)
                                    .padding(.bottom, 5)

                                Slider(
                                    value: $effort,
                                    in: 0...5
                                )
                                .tint(.yellow)

                            }
                            .padding(20)
                            .frame(
                                maxWidth: .infinity,
                                alignment: .leading
                            )
                            .background(.white)
                            .cornerRadius(12)
                            .padding(.horizontal,10)

                            VStack(alignment:.leading, spacing: 6){

                                Text("Frustration:")
                                    .foregroundStyle(teal)
                                    .font(.title2)
                                    .fontWeight(.semibold)

                                Text("Question:")
                                    .foregroundStyle(teal)

                                Text(
                                    "How Frustated or Stressed did you feel during task?"
                                )

                                Text("Helper Text:")
                                    .foregroundStyle(teal)

                                Text(
                                    "Did You Fell Irritated, Anxious, or Discouraged While Coding?"
                                )

                                Text("\(Int(frustration))")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                    .padding(.bottom, 5)

                                Slider(
                                    value: $frustration,
                                    in: 0...5
                                )
                                .tint(.blue)

                            }
                            .padding(20)
                            .frame(
                                maxWidth: .infinity,
                                alignment: .leading
                            )
                            .background(.white)
                            .cornerRadius(12)
                            .padding(.horizontal,10)

                            VStack(alignment: .leading){

                                if userresponce.isEmpty {

                                    VStack(alignment:.leading) {

                                        Text(
                                            "Type Your Coding Experience\nYour Responce Help Us Understand\nYour Coding Experience."
                                        )
                                    }
                                    .foregroundColor(.gray)
                                }

                                TextEditor(
                                    text: $userresponce
                                )
                                .frame(
                                    width: 340,
                                    height: 70
                                )
                                .autocapitalization(.none)
                            }
                            .padding(10)
                            .background(.white)
                            .cornerRadius(12)
                            .frame(maxWidth: .infinity)

                            Button {

                                viewModel.submitSelfReportData(
                                    mental: Int(mental),
                                    effort: Int(effort),
                                    frustration: Int(frustration),
                                    comments: userresponce
                                )
                                
                                report = true

                            } label: {

                                if viewModel.selfReportLoading {

                                    ProgressView()
                                        .tint(.white)

                                } else {

                                    Text("Sumbits")
                                        .fontWeight(.semibold)
                                }
                            }
                            .padding(.vertical,10)
                            .padding(.horizontal,25)
                            .background(teal)
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                            .disabled(
                                viewModel.selfReportLoading
                            )
                        }
                    }
                    .padding(12)
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal,30)
                }
                .alert(
                    "Sumbitted!",
                    isPresented: $responcealert
                ){

                    Button(
                        "OK",
                        role: .cancel
                    ){}

                } message: {

                    Text(
                        viewModel.selfReportError ??
                        "Your Responce Was Sumbitted Successfully"
                    )
                }
            }
        }

        .onReceive(viewModel.$selfReportData) { response in

            guard let response = response else { return }

            guard let sid = response.sessionid else {

                print("❌ Missing Session ID")
                return
            }

            print("🧾 Self Report Submitted:", sid)

            reportmodel.predictSession(
                sessionId: sid
            )
        }

        .onReceive(reportmodel.$predictionReport) { prediction in

            guard prediction != nil else { return }

            print("✅ Prediction Completed")

            responcealert = true

            DispatchQueue.main.asyncAfter(
                deadline: .now() + 1
            ){

                report = true
            }
        }

        .onReceive(viewModel.$selfReportError) { error in

            if let error = error {

                print("❌ Self Report Error:", error)

                responcealert = true
            }
        }

//        .navigationDestination(
//            isPresented: $report,
//            destination: {
//
//                MainContainerView(
//                    studentId: studentid,
//                    sessionid: sessionid
//                )
//            }
//        )
        
        .navigationDestination(
            isPresented: $report,
            destination: {ReportScreen(sid: studentid, sessionid: sessionid)
            }
        )

        .navigationBarBackButtonHidden(true)
    }
}

struct NumberScale: View {

    @Binding var currentvalue : Double

    var body: some View {

        HStack {

            ForEach(0...10,id: \.self){ number in

                Text("\(number)")
                    .font(
                        .system(
                            size: 15,
                            weight: .bold
                        )
                    )
                    .frame(maxWidth:.infinity)
            }
        }
    }
}

#Preview {

    SelfReport(
        studentid: 0,
        sessionid: 0,
        selectedtab: .constant(0)
    )
}
