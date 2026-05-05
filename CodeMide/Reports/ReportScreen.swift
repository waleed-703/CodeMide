import SwiftUI
import Charts

struct eegdata : Identifiable{
    let id = UUID()
    let x : Double
    let y : Double
    let bandtype : String
}

struct ppgdata: Identifiable {
    let id = UUID()
    let x: Double
    let y: Double
    let type: String
}

struct ReportScreen: View {
    @Environment(\.dismiss) var dismiss
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
    @StateObject private var viewModel = ReportViewModel()
    @StateObject private var eegviewModel = GraphViewModel()
    @StateObject private var ppgViewModel = PPGViewModel()
    let sid : Int
    let sessionid : Int
    var body: some View {
        ZStack{
            teal.ignoresSafeArea()
            VStack{
                ScrollView{
                    VStack(spacing : 20){
                        VStack(alignment: .leading){
                            HStack{
                                Spacer()
                                Image("codemide")
                                    .resizable()
                                    .frame(width: 80,height: 80)
                                Spacer()
                            }
                            
                            Text("\(viewModel.sessionReport?.student_name ?? "")!")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
//                            Text("8th Semester")
//                                .font(.title2)
//                                .fontWeight(.semibold)
//                                .foregroundStyle(.white)

                            VStack(alignment:.leading,spacing: 6){
                                Text("Over All Stress & Performance Summary")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.teal)
                                
                                HStack {
                                    Text("Final Stress Level")
                                        .foregroundStyle(teal)
//                                    Text("\(viewModel.sessionReport?.final_stress_level ?? "")")
                                    Text(stressLevelText(viewModel.sessionReport?.final_stress_level))
                                }
                                
//                                HStack{
//                                    Text("Cognitive Load:")
//                                        .foregroundStyle(teal)
//                                    Text("High")
//                                }
                                HStack{
                                    Text("Date:")
                                        .foregroundStyle(.teal)
                                    Text("\(viewModel.sessionReport?.date ?? "")")
                                    
                                }
                                HStack{
                                    Text("Complete Time:")
                                        .foregroundStyle(.teal)
                                    Text("\(viewModel.sessionReport?.total_minutes ?? 0) sec")
                                }
                                HStack{
                                    Text("Stress Index:")
                                        .foregroundStyle(.teal)
                                    Text("\(viewModel.sessionReport?.SI ?? 0, specifier: "%.3f")")
                                }
                                
                                Divider()
                                    .frame(width: 250)
                                VStack(alignment: .leading,spacing: 6){
                                    Text("Before Question Blood Pressure:")
                                        .foregroundStyle(teal)
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                    
                                    HStack{
                                        Text("Systolic / Diastolic :")
                                        
                                        Text("\(viewModel.sessionReport?.average_bpb ?? "") mmHg")
                                            .foregroundStyle(teal)
                                    }
                                    
                                    Text("After Question Blood Pressure:")
                                        .foregroundStyle(teal)
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                    
                                    HStack{
                                        Text("Systolic / Diastolic :")
                                        
                                        Text("\(viewModel.sessionReport?.average_bpa ?? "") mmHg")
                                            .foregroundStyle(teal)
                                    }
                                    
                                    Divider()
                                        .frame(width: 250)
                //                    Spacer()
                                    Text("Heart Rate Variability(PPG):")
                                        .foregroundStyle(teal)
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    
                                    HStack{
                                        Text("Average Heart Rate :")
                                        Text("\(viewModel.sessionReport?.HR ?? 0, specifier: "%.3f")bpm")
                                            .foregroundStyle(teal)
                                    }
                                    HStack{
                                        Text("SDNN :")
                                        Text("\(viewModel.sessionReport?.SDNN ?? 0, specifier: "%.3f") ms")
                                            .foregroundStyle(teal)
                                    }
                                    HStack{
                                        Text("RMSSD :")
                                        Text("\(viewModel.sessionReport?.RMSSD ?? 0, specifier: "%.3f") ms")
                                            .foregroundStyle(teal)
                                    }
                                    
                                    Divider()
                                        .frame(width: 250)
                                    
                                    Text("Higher RMMSD And SDNN indicate better relaxation and autonomic balance.")
                                        .foregroundStyle(.gray)
                                        .font(.caption)
                                    
                                }
//                                .padding()
//                                .background(.white)
//                                .cornerRadius(12)
////                                .padding(.vertical,5)
//                                .padding(.horizontal,25)

                                
                            }
                            .padding(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.white)
                            .cornerRadius(12)
//                            .padding(.horizontal,10)
                            
                            
                            VStack(alignment: .leading){
                                Text("Physiological Signals During Session")
                                    .fontWeight(.bold)
                                    .foregroundStyle(.teal)
                                
                                VStack{
                                    Text("EEG Bands Power Across Time")
                                        .font(.caption)
                                    Chart(eegviewModel.points){point in
                                        LineMark(x: .value("Time",point.x),
                                                 y: .value("Value",point.y)
                                        )
                                        .foregroundStyle(by: .value("Band", point.bandtype))
                                    }
                                    .chartYAxis {
                                        AxisMarks(position: .leading)
                                    }
                                    .overlay(alignment: .leading) {
                                        Text("Power")
                                            .font(.caption)
//                                            .foregroundColor(.gray)
                                            .rotationEffect(.degrees(-90))
                                            .offset(x: -35)
                                    }
                                    .frame(height: 200)
                                    .padding(.leading)
                                    Text("Time(seconds)")
                                        .font(.caption)
                                    
                                    VStack(alignment: .leading ,spacing: 5){
                                        Text("EEG Power Bands Summary:")
                                            .foregroundStyle(teal)
                                            .fontWeight(.semibold)
                                        Text("Alpha Power -> Relxation")
                                            .foregroundStyle(.gray)
                                        Text("Beta Power -> Focus / Stress")
                                            .foregroundStyle(.gray)
                                        Text("Theta -> Mental Workload")
                                            .foregroundStyle(.gray)
                                    }
                                }
                            }
                            .padding(20)
                            .background(.white)
                            .cornerRadius(12)
                            
                            VStack {
                                Text("PPG (Heart Rate Variability) Over Time")
                                    .font(.caption)

                                Chart(ppgViewModel.ppgPoints) { point in
                                    LineMark(
                                        x: .value("Time", point.x),
                                        y: .value("Value", point.y)
                                    )
                                    .foregroundStyle(by: .value("Type", point.type))
                                }
                                .chartYAxis {
                                    AxisMarks(position: .leading)
                                }
                                .overlay(alignment: .leading) {
                                    Text("Value")
                                        .font(.caption)
                                        .rotationEffect(.degrees(-90))
                                        .offset(x: -35)
                                }
                                .frame(height: 200)
                                .padding(.leading)

                                Text("Time(seconds)")
                                    .font(.caption)

                                VStack(alignment: .leading, spacing: 5) {
                                    Text("PPG Metrics:")
                                        .foregroundStyle(teal)
                                        .fontWeight(.semibold)

                                    Text("HR -> Heart Rate")
                                        .foregroundStyle(.gray)

                                    Text("SDNN -> HR Variability")
                                        .foregroundStyle(.gray)

                                    Text("RMSSD -> Parasympathetic Activity")
                                        .foregroundStyle(.gray)
                                    Text("pNN50 -> Parasympathetic Balance")
                                        .foregroundStyle(.gray)
                                }
                            }
                            .padding(20)
                            .background(.white)
                            .cornerRadius(12)

                            VStack(alignment: .leading, spacing: 10){
                                Text("Self Report:")
                                    .foregroundStyle(teal)
                                    .fontWeight(.bold)
                                    .font(.title3)
                                
                                HStack{
                                    Text("Mental Load:")
                                    Text("\(viewModel.selfReport?.mentalLoad ?? 0)")
                                        .foregroundStyle(teal)
                                }
                                HStack{
                                    Text("Frustration:")
                                    Text("\(viewModel.selfReport?.frustration ?? 0)")
                                        .foregroundStyle(teal)
                                }
                                HStack{
                                    Text("Effort:")
                                    Text("\(viewModel.selfReport?.effort ?? 0)")
                                        .foregroundStyle(teal)
                                }
                                HStack{
                                    Text("Comments:")
                                    Text("\(viewModel.selfReport?.comment ?? "")")
                                        .foregroundStyle(teal)
                                }
                            }
                            .padding(10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(.white)
                            .cornerRadius(12)
                            
                            VStack(alignment: .leading){
                                Text("Reports Of Each Question")
                                    .foregroundStyle(teal)
                                    .fontWeight(.bold)
//                                    .font(.title2)
                                if let questions = viewModel.sessionReport?.attempted_questions, !questions.isEmpty {
                                    ForEach(questions ,id: \.qid){question in
                                        VStack(alignment: .leading){
                                            VStack(alignment: .leading) {
                                                Text("Q:\(String(question.qid))")
                                                .foregroundStyle(.white)
                                                .fontWeight(.semibold)
                                            
                                                Text(question.description)
                                                .foregroundStyle(.white)
                                        }
                                        
                                        
                                        
                                        NavigationLink{
                                            QuestionReport(question : question,sessionid : sessionid,sid : sid, qid: question.qid)
                                        }label: {
                                            Image(systemName: "doc.on.clipboard.fill")
                                            Text("Report")
                                                .font(.subheadline)
                                        }
                                        .padding(.horizontal,10)
                                        .padding(.vertical, 10)
                                        .foregroundStyle(teal)
                                        .background(Color.white)
                                        .clipShape(Capsule())
                                        .frame(maxWidth: .infinity)
                                        
                                        
                                    }
                                        .padding(20)
                                        .frame(maxWidth: .infinity,alignment: .leading)
                                        .background(teal)
                                        .cornerRadius(12)
                                }

                                    
                                }
                                else{
                                    VStack{
                                        Spacer()
                                        Text("No Question Record Found!")
                                            .foregroundStyle(.gray)
                                    }
                                    .padding(.horizontal,70)
                                    
                                }

//                                    .padding(.vertical,20)
//                                    .padding(.horizontal,12)
                                
                                    
//                                }
                            }
                            .padding(20)
//                            .padding(.vertical,20)
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .background(.white)
                            .cornerRadius(12)
//                            .padding(.horizontal,1)
                        }
                        .padding()
                        
                        .onAppear{
                            viewModel.getstudentreport(sid: sid, sessionid: sessionid)
                            eegviewModel.getgraphdata(sessionid: String(sessionid), sid: String(sid))
                            ppgViewModel.getAllPPG(sessionID: String(sessionid), sid: String(sid))
//                            viewModel.getselfreport(sessionid: sessionid)
                        }
                        .task {
                            viewModel.getselfreport(sessionid: sessionid)
                        }
                    }

                }
             
            }
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
    NavigationStack{
        ReportScreen(sid :0, sessionid: 0)
    }
}
