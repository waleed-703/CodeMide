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

    let questionId : Int

    // MARK: - FILTER STATES

    @State private var selectedGender = ""
    @State private var selectedSemester = ""
    @State private var selectedGPT = ""

    @State private var minCGPA = ""
    @State private var maxCGPA = ""

    let genders = ["", "Male", "Female"]
    let semesters = ["", "1", "2", "3", "4", "5", "6", "7", "8"]
    let gptOptions = ["", "0", "1"]

    var body: some View {

        ZStack {

            teal.ignoresSafeArea()

            ScrollView {

                VStack {

                    // MARK: HEADER

                    VStack {

                        Image("codemide")
                            .resizable()
                            .frame(width: 100,height: 100)

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

                    VStack(alignment: .leading){

                        Text("QuestionStatement:")
                            .foregroundStyle(teal)

                        Text("\(viewModel.report?.description ?? "")")

                    }
                    .padding(25)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .background(.white)
                    .cornerRadius(12)
                    .padding(.horizontal,25)

                    // MARK: FILTER SECTION

                    VStack(alignment: .leading, spacing: 15) {

                        Text("Filter Reports")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(teal)

                        // Gender Picker

                        Picker("Gender", selection: $selectedGender) {

                            Text("All").tag("")

                            ForEach(genders.dropFirst(), id: \.self) { gender in

                                Text(gender).tag(gender)
                            }
                        }
                        .pickerStyle(.menu)

                        // Semester Picker

                        Picker("Semester", selection: $selectedSemester) {

                            Text("All").tag("")

                            ForEach(semesters.dropFirst(), id: \.self) { sem in

                                Text("Semester \(sem)").tag(sem)
                            }
                        }
                        .pickerStyle(.menu)

                        // GPT Picker

                        Picker("GPT Usage", selection: $selectedGPT) {

                            Text("All").tag("")

                            Text("Without GPT").tag("0")

                            Text("With GPT").tag("1")
                        }
                        .pickerStyle(.menu)

                        // CGPA

                        HStack {

                            TextField("Min CGPA", text: $minCGPA)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad)

                            TextField("Max CGPA", text: $maxCGPA)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad)
                        }

                        // FILTER BUTTON

                        Button {

                            viewModel.filterQuestionReports(

                                qid: questionId,

                                gender: selectedGender.isEmpty ? nil : selectedGender,

                                minCGPA: Double(minCGPA),

                                maxCGPA: Double(maxCGPA),

                                semester: selectedSemester.isEmpty ? nil : selectedSemester,

                                gptindex: Int(selectedGPT)
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

                        if viewModel.filteredReports.isEmpty {

                            Text("No Filtered Reports")
                                .foregroundStyle(.white)
                                .padding(.horizontal)

                        } else {

                            ForEach(viewModel.filteredReports) { report in

                                VStack(alignment: .leading, spacing: 10) {

                                    Text(report.student_name)
                                        .font(.headline)

                                    HStack {

                                        Text("Gender:")
                                            .foregroundStyle(teal)

                                        Text(report.gender)
                                    }

                                    HStack {

                                        Text("CGPA:")
                                            .foregroundStyle(teal)

                                        Text("\(report.cgpa)")
                                    }

                                    HStack {

                                        Text("Semester:")
                                            .foregroundStyle(teal)

                                        Text(report.semester)
                                    }

                                    HStack {

                                        Text("GPT:")
                                            .foregroundStyle(teal)

                                        Text(report.gptindex == 1 ? "With GPT" : "Without GPT")
                                    }

                                    HStack {

                                        Text("BP:")
                                            .foregroundStyle(teal)

                                        Text(report.bp ?? "N/A")
                                    }

                                    HStack {

                                        Text("Heart Rate:")
                                            .foregroundStyle(teal)

                                        Text("\(report.heartRate ?? 0)")
                                    }

                                    HStack {

                                        Text("SDNN:")
                                            .foregroundStyle(teal)

                                        Text("\(report.sdnn ?? 0)")
                                    }

                                    HStack {

                                        Text("RMSSD:")
                                            .foregroundStyle(teal)

                                        Text("\(report.rmssd ?? 0)")
                                    }

                                    HStack {

                                        Text("Stress Level:")
                                            .foregroundStyle(teal)

                                        Text(report.stressLevel ?? "N/A")
                                    }

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
                .onAppear {

                    viewModel.fetchadminreport(questionId: questionId)
                }
            }
        }
    }
}

#Preview {

    AdminReport(questionId: 1)
}
