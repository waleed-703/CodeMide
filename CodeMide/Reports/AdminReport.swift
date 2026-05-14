//import SwiftUI
//
//struct AdminReport: View {
//    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
//    @StateObject private var viewModel = ReportViewModel()
//    let questionId : Int
//    var body: some View {
//        ZStack{
//            teal.ignoresSafeArea()
//                ScrollView{
//                    VStack{
//                        VStack{
//                            Image("codemide")
//                                .resizable()
//                                .frame(width: 100,height: 100)
//                            Text("Question Report")
//                                .foregroundStyle(.white)
//                                .font(.title)
//                                .fontWeight(.bold)
//                            
//                            Divider()
//                                .overlay(Color.white)
//                                .frame(width: 350)
//        //                        .padding()
//                            
//                            Text("Total Student Attempts - \(viewModel.report?.total_attempts ?? 0)")
//                                .foregroundStyle(.white)
//        //                        .font(.title3)
//                                .fontWeight(.semibold)
//                            
//                            HStack
//                            {
//                                Image(systemName: "clock")
//                                Text("\(viewModel.report?.duration ?? 0) mins")
//                            }
//                            .padding(.vertical, 6)
//                            .padding(.horizontal, 12)
//                            .background(Color.white.opacity(0.3))
//                            .clipShape(Capsule())
//    //                        .foregroundStyle(.black)
//                        }
//                        
//                        VStack(alignment: .leading){
//                            
//                            Text("QuestionStatement:")
//                                    .foregroundStyle(teal)
//                            Text("\(viewModel.report?.description ?? "")")
//                            
//                        }
//                        .padding(25)
//                        .frame(maxWidth: .infinity,alignment: .leading)
//                        .background(.white)
//                        .cornerRadius(12)
//        //                .padding(.vertical,)
//                        .padding(.horizontal,25)
//                        
//                        VStack(alignment: .leading){
//                            Text("OverAll Average Stress\nWith ChatGpt")
//                                .foregroundStyle(teal)
//                                .font(.title2)
//                                .fontWeight(.semibold)
//                            HStack{
//                                Text("Final Stress Level:")
//                                    .foregroundStyle(teal)
//                                Text(viewModel.report?.with_gpt.most_common_stress_level ?? "")
//                            }
//                            
//                            Divider()
//                                .frame(width: 250)
//                            
//                            Text("Blood Pressure (BP) Analysis:")
//                                .foregroundStyle(teal)
//                                .fontWeight(.semibold)
//                                .font(.title3)
//                            
//                            HStack{
//                                Text("Systolic / Diastolic :")
//                                
//                                Text("\(viewModel.report?.with_gpt.avg_bp ?? "")")
//                                    .foregroundStyle(teal)
//                            }
//                            
//                            Divider()
//                                .frame(width: 250)
//        //                    Spacer()
//                            Text("Heart Rate Variability(PPG):")
//                                .foregroundStyle(teal)
//                                .font(.title3)
//                                .fontWeight(.semibold)
//                            
//                            HStack{
//                                Text("Average Heart Rate :")
//                                Text("\(viewModel.report?.with_gpt.avg_hr ?? "") bpm")
//                                    .foregroundStyle(teal)
//                            }
//                            HStack{
//                                Text("SDNN :")
//                                Text("\(viewModel.report?.with_gpt.avg_sdnn ?? "") ms")
//                                    .foregroundStyle(teal)
//                            }
//                            HStack{
//                                Text("RMSSD:")
//                                Text("\(viewModel.report?.with_gpt.avg_rmssd ?? "") bpm")
//                                    .foregroundStyle(teal)
//                            }
//                            
//                            Divider()
//                                .frame(width: 250)
//                            
//                            Text("Higher RMMSD And SDNN indicate better relaxation and autonomic balance.")
//                                .foregroundStyle(.gray)
//                                .font(.caption)
//                            
//                        }
//                        .padding(20)
//                        .frame(maxWidth: .infinity,alignment: .leading)
//                        .background(.white)
//                        .cornerRadius(12)
//                        .padding(.horizontal,25)
//                        
//                        
//                        
//                        
//                        VStack(alignment: .leading){
//                            Text("OverAll Average Stress\nWithout ChatGpt")
//                                .foregroundStyle(teal)
//                                .font(.title2)
//                                .fontWeight(.semibold)
//                            HStack{
//                                Text("Final Stress Level:")
//                                    .foregroundStyle(teal)
//                                Text(viewModel.report?.without_gpt.most_common_stress_level ?? "")
//                            }
//                            
//                            Divider()
//                                .frame(width: 250)
//                            
//                            Text("Blood Pressure (BP) Analysis:")
//                                .foregroundStyle(teal)
//                                .fontWeight(.semibold)
//                                .font(.title3)
//                            
//                            HStack{
//                                Text("Systolic / Diastolic :")
//                                
//                                Text("\(viewModel.report?.without_gpt.avg_bp ?? "")")
//                                    .foregroundStyle(teal)
//                            }
//                            
//                            Divider()
//                                .frame(width: 250)
//        //                    Spacer()
//                            Text("Heart Rate Variability(PPG):")
//                                .foregroundStyle(teal)
//                                .font(.title3)
//                                .fontWeight(.semibold)
//                            
//                            HStack{
//                                Text("Average Heart Rate :")
//                                Text("\(viewModel.report?.without_gpt.avg_hr ?? "") bpm")
//                                    .foregroundStyle(teal)
//                            }
//                            HStack{
//                                Text("SDNN :")
//                                Text("\(viewModel.report?.without_gpt.avg_sdnn ?? "") ms")
//                                    .foregroundStyle(teal)                            }
//                            HStack{
//                                Text("RMSSD: ")
//                                Text("\(viewModel.report?.without_gpt.avg_rmssd ?? "") bpm")
//                                    .foregroundStyle(teal)
//                            }
//                            
//                            Divider()
//                                .frame(width: 250)
//                            
//                            Text("Higher RMMSD And SDNN indicate better relaxation and autonomic balance.")
//                                .foregroundStyle(.gray)
//                                .font(.caption)
//                            
//                        }
//                        .padding(20)
//                        .frame(maxWidth: .infinity,alignment: .leading)
//                        .background(.white)
//                        .cornerRadius(12)
//                        .padding(.horizontal,25)
//                        
//                        Spacer()
//                    }
//                    .onAppear{
//                        print("id",questionId)
//                        viewModel.fetchadminreport(questionId: questionId)
//                    }
//                }
//
//
//            
//
//
////            }
//        }
//    }
//}
//
//#Preview {
//    AdminReport(questionId: 0)
//}
//
//


import SwiftUI

struct AdminReport: View {

    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)

    @StateObject private var viewModel = ReportViewModel()

    let questionId: Int

    // MARK: FILTER STATES

    @State private var selectedGender: String? = nil
    @State private var selectedSemester: String? = nil
    @State private var selectedGPT: String? = nil

    @State private var minCGPA = ""
    @State private var maxCGPA = ""

    let genders = ["Male", "Female"]
    let semesters = ["1","2","3","4","5","6","7","8"]

    var body: some View {

        ZStack {

            teal
                .ignoresSafeArea()

            ScrollView {

                VStack(spacing: 20) {

                    // MARK: HEADER

                    VStack(spacing: 10) {

                        Image("codemide")
                            .resizable()
                            .frame(width: 100, height: 100)

                        Text("Question Report")
                            .foregroundStyle(.white)
                            .font(.title)
                            .fontWeight(.bold)

                        Divider()
                            .overlay(Color.white)
                            .frame(width: 350)

                        Text("Total Student Attempts - \(viewModel.report?.total_attempts ?? 0)")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)

                        HStack {

                            Image(systemName: "clock")

                            Text("\(viewModel.report?.duration ?? 0) mins")
                        }
                        .padding(.vertical, 6)
                        .padding(.horizontal, 12)
                        .background(Color.white.opacity(0.3))
                        .clipShape(Capsule())
                    }

                    // MARK: QUESTION

                    VStack(alignment: .leading, spacing: 10) {

                        Text("Question Statement:")
                            .foregroundStyle(teal)
                            .fontWeight(.bold)

                        Text(viewModel.report?.description ?? "No Description")
                    }
                    .padding(25)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
                    .cornerRadius(12)
                    .padding(.horizontal, 25)

                    // MARK: FILTER SECTION

                    VStack(alignment: .leading, spacing: 15) {

                        Text("Filter Reports")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(teal)

                        // MARK: GENDER PICKER

                        Picker("Gender", selection: $selectedGender) {

                            Text("Nil")
                                .tag(String?.none)

                            ForEach(genders, id: \.self) { gender in

                                Text(gender)
                                    .tag(Optional(gender))
                            }
                        }
                        .pickerStyle(.menu)

                        // MARK: SEMESTER PICKER

                        Picker("Semester", selection: $selectedSemester) {

                            Text("Nil")
                                .tag(String?.none)

                            ForEach(semesters, id: \.self) { sem in

                                Text("Semester \(sem)")
                                    .tag(Optional(sem))
                            }
                        }
                        .pickerStyle(.menu)

                        // MARK: GPT PICKER

                        Picker("GPT Usage", selection: $selectedGPT) {

                            Text("Nil")
                                .tag(String?.none)

                            Text("Without GPT")
                                .tag(Optional("0"))

                            Text("With GPT")
                                .tag(Optional("1"))
                        }
                        .pickerStyle(.menu)

                        // MARK: CGPA

                        HStack {

                            TextField("Min CGPA", text: $minCGPA)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad)

                            TextField("Max CGPA", text: $maxCGPA)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad)
                        }

                        // MARK: BUTTON

                        Button {

                            viewModel.filterQuestionReports(

                                qid: questionId,

                                gender: selectedGender,

                                minCGPA: minCGPA.isEmpty ? nil : Double(minCGPA),

                                maxCGPA: maxCGPA.isEmpty ? nil : Double(maxCGPA),

                                semester: selectedSemester,

                                gptindex: selectedGPT == nil ? nil : Int(selectedGPT!)
                            )

                        } label: {

                            Text("Apply Filters")
                                .foregroundStyle(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(teal)
                                .cornerRadius(12)
                        }

                    }
                    .padding()
                    .background(.white)
                    .cornerRadius(12)
                    .padding(.horizontal, 25)

                    // MARK: FILTERED REPORTS

                    VStack(alignment: .leading, spacing: 15) {

                        Text("Filtered Reports")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(.horizontal)

                        // MARK: LOADING

                        if viewModel.isLoading == true {

                            ProgressView()
                                .tint(.white)
                                .padding()

                        }

                        // MARK: EMPTY

                        else if viewModel.filteredReports.isEmpty {

                            Text("No Reports Found")
                                .foregroundStyle(.white)
                                .padding(.horizontal)

                        }

                        // MARK: DATA

                        else {

                            ForEach(viewModel.filteredReports) { report in

                                VStack(alignment: .leading, spacing: 10) {

                                    Text(report.student_name)
                                        .font(.headline)

                                    infoRow(title: "Gender", value: report.gender)

                                    infoRow(title: "CGPA", value: "\(report.cgpa)")

                                    infoRow(title: "Semester", value: "\(report.semester)")

                                    infoRow(
                                        title: "GPT",
                                        value: report.gptindex == 1
                                        ? "With GPT"
                                        : "Without GPT"
                                    )

                                    infoRow(
                                        title: "BP",
                                        value: report.bp ?? "N/A"
                                    )

                                    infoRow(
                                        title: "Heart Rate",
                                        value: "\(report.heartRate ?? 0)"
                                    )

                                    infoRow(
                                        title: "SDNN",
                                        value: "\(report.sdnn ?? 0)"
                                    )

                                    infoRow(
                                        title: "RMSSD",
                                        value: "\(report.rmssd ?? 0)"
                                    )

                                    infoRow(
                                        title: "Stress Level",
                                        value: report.stressLevel ?? "N/A"
                                    )

                                }
                                .padding()
                                .background(.white)
                                .cornerRadius(12)
                                .padding(.horizontal, 25)
                            }
                        }
                    }

                    Spacer()
                }
                .padding(.vertical)
                .onAppear {

                    viewModel.fetchadminreport(questionId: questionId)
                }
            }
        }
    }

    // MARK: REUSABLE ROW

    func infoRow(title: String, value: String) -> some View {

        HStack {

            Text("\(title):")
                .foregroundStyle(teal)
                .fontWeight(.semibold)

            Text(value)
        }
    }
}

#Preview {

    AdminReport(questionId: 1)
}
