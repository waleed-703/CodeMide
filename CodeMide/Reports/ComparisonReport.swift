import SwiftUI
import Charts
struct ComparisonReport: View {
    
//    enum ProductType: String, CaseIterable {
//        case stresslevel = "Stress"
//        case cgpa = "CGPA"
//        case gender = "Gender"
//    }
    
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
    @State private var selectedGender: String? = nil
//    @State private var selectedSemester: String? = nil
//    @State private var selectedGPT: String? = nil
//    @State var type : ProductType = .stresslevel
    @State private var minCGPA = ""
    @State private var maxCGPA = ""
    @StateObject private var viewModel = ReportViewModel()
    @StateObject private var eegviewModel = GraphViewModel()
    let studentId : Int
    let sessionid : Int
    
    //    @StateObject private var viewModel = ReportViewModel()
    let genders = ["CGPA", "Gender","StressLevel"]
    
    var body: some View{
        //
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

                    }
                    
                    // MARK: QUESTION
                    
//                    VStack(alignment: .leading, spacing: 10) {
//                        
//                        Text("Question Statement:")
//                            .foregroundStyle(teal)
//                            .fontWeight(.bold)
//                        
//                        Text(viewModel.report?.description ?? "No Description")
//                    }
//                    .padding(25)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .background(.white)
//                    .cornerRadius(12)
//                    .padding(.horizontal, 25)
                    
                    // MARK: FILTER SECTION
                    
                    VStack(alignment: .leading, spacing: 15) {
                        
                        Text("Filter Reports")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(teal)
                        
                        // MARK: GENDER PICKER
                        
                        Picker("Gender", selection: $selectedGender) {
                            
                            Text("NIL")
                                .tag(String?.none)
                            
                            ForEach(genders, id: \.self) { gender in
                                
                                Text(gender)
                                    .tag(Optional(gender))
                            }
                        }
                        .pickerStyle(.menu)
                        
                        // MARK: SEMESTER PICKER
                        
//                        Picker("Semester", selection: $selectedSemester) {
//                            
//                            Text("Nil")
//                                .tag(String?.none)
//                            
//                            ForEach(semesters, id: \.self) { sem in
//                                
//                                Text("Semester \(sem)")
//                                    .tag(Optional(sem))
//                            }
//                        }
//                        .pickerStyle(.menu)
                        
                        // MARK: GPT PICKER
                        
//                        Picker("GPT Usage", selection: $selectedGPT) {
//                            
//                            Text("Nil")
//                                .tag(String?.none)
//                            
//                            Text("Without GPT")
//                                .tag(Optional("0"))
//                            
//                            Text("With GPT")
//                                .tag(Optional("1"))
//                        }
//                        .pickerStyle(.menu)
                        
                        // MARK: CGPA
                        
//                        HStack {
//                            
//                            TextField("Min CGPA", text: $minCGPA)
//                                .textFieldStyle(.roundedBorder)
//                                .keyboardType(.decimalPad)
//                            
//                            TextField("Max CGPA", text: $maxCGPA)
//                                .textFieldStyle(.roundedBorder)
//                                .keyboardType(.decimalPad)
//                        }
                        
                        // MARK: BUTTON
                        
                        Button {
                            
                            viewModel.filterQuestionReports(
                                
//                                qid: questionId,
                                
                                gender: "genders"
                        
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
                                    
                                    infoRow(title: "Date", value: "\(report.date ?? "")")
                                    
                                    infoRow(title: "Gender", value: "\(report.gender)")
                                    
                                    infoRow(title: "CGPA", value: "\(report.cgpa ?? "")")
                                    infoRow(
                                        title: "Before Question BP",
                                        value: report.bpb ?? "N/A"
                                    )
                                    infoRow(
                                        title: "Mid Question BP",
                                        value: report.bpm ?? "N/A"
                                    )
                                    infoRow(
                                        title: "After Question BP",
                                        value: report.bpa ?? "N/A"
                                    )
                                    
                                    infoRow(
                                        title: "Heart Rate",
                                        value: "\(String(format: "%.2f",report.hr ?? 0))"
                                    )
                                    
                                    infoRow(
                                        title: "SDNN",
                                        value: "\(String(format: "%.2f",report.sdnn ?? 0))"
                                    )
                                    
                                    infoRow(
                                        title: "RMSSD",
                                        value: "\(String(format: "%.2f",report.rmssd ?? 0))"
                                    )
                                    
                                    infoRow(
                                        title: "Stress Level",
                                        value: "\(stressLevelText(report.stressLevel))"
                                    )
                                    
                                    infoRow(title: "SI", value: "\(String(format: "%.2f",report.si ?? 0))")
                                    
//                                    VStack(alignment: .leading){
//                                        Text("Physiological Signals During Session")
//                                            .font(.title3)
//                                            .fontWeight(.semibold)
//                                            .foregroundStyle(.teal)
//                                        
//                                        VStack{
//                                            Text("EEG Bands Power Across Time")
//                                                .font(.caption)
//                                            Chart(eegviewModel.points){point in
//                                                LineMark(x: .value("Time",point.x),
//                                                         y: .value("Value",point.y)
//                                                )
//                                                .foregroundStyle(by: .value("Band", point.bandtype))
//                                            }
//                                            .chartYAxis {
//                                                AxisMarks(position: .leading)
//                                            }
//                                            .overlay(alignment: .leading) {
//                                                Text("Power")
//                                                    .font(.caption)
//            //                                            .foregroundColor(.gray)
//                                                    .rotationEffect(.degrees(-90))
//                                                    .offset(x: -35)
//                                            }
//                                            .frame(height: 200)
//                                            .padding(.leading)
//                                            Text("Time(seconds)")
//                                                .font(.caption)
//                                            
//                                            VStack(alignment: .leading ,spacing: 5){
//                                                Text("EEG Power Bands Summary:")
//                                                    .foregroundStyle(teal)
//                                                    .fontWeight(.semibold)
//                                                Text("Alpha Power -> Relxation")
//                                                    .foregroundStyle(.gray)
//                                                Text("Beta Power -> Focus / Stress")
//                                                    .foregroundStyle(.gray)
//                                                Text("Theta -> Mental Workload")
//                                                    .foregroundStyle(.gray)
//                                            }
//                                        }
//                                    }
//                                    .padding(20)
//                                    .background(.white)
//                                    .cornerRadius(12)
                                }
                                .padding(20)
                                .frame(maxWidth: .infinity,alignment: .leading)
                                .background(.white)
                                .cornerRadius(12)
                                //                    .padding(.vertical,5)
                                .padding(.horizontal,25)
                                



                           }
                        }
                        

                    }
                    
                    Spacer()
                }
                
                .onAppear(){
                    eegviewModel.getgraphdata(sessionid: String(sessionid), sid: String(studentId))
                }
//                .padding(.vertical)
                .onAppear {
                    
                    //                        viewModel.fetchadminreport(questionId: questionId)
                }
            }
        }
        
        //    }
        
    }
    func infoRow(title: String, value: String) -> some View {
        
        HStack {
            
            Text("\(title):")
                .foregroundStyle(teal)
                .fontWeight(.semibold)
            
            Text(value)
        }
    }
    func stressLevelText(_ value: String?) -> String {
        switch Int(value ?? "") {
        case 0: return "Low"
        case 1: return "Medium"
        case 2: return "High"
        default: return "--"
        }
    }


}

#Preview {
    ComparisonReport(studentId: 0, sessionid: 0)
}
