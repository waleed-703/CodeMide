import SwiftUI

struct AllReportsScreen: View {
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
    @StateObject var viewModel = ReportViewModel()
    let studentId : Int
    var body: some View {
        ZStack{
            teal.ignoresSafeArea()

            VStack(){
//                ScrollView(){
                    VStack(spacing: 10){
                        HStack{
                            Image("codemide")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 70, height: 70)
                        }
                        VStack(alignment: .leading, spacing: 10){
                            Text("Session History:")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundStyle(teal)
                            Text("All Sessions")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundStyle(teal)
                            
                            ScrollView(){
                                if viewModel.reports.isEmpty{
                                    VStack{
                                        Spacer()
                                        Text("No Session History Found!")
                                            .foregroundStyle(.gray)
//                                            .multilineTextAlignment(.center)
                                        Spacer()
                                        
                                    }
                                    .frame(minHeight: 500)
                                    .padding(.horizontal,70)
                                }else{
                                    
                                }
                                ForEach(viewModel.reports){report in
                                    reportCard(
//                                        date: report.date,
//                                        bp: "\(report.afterQuestionBP)\nmmHg",
//                                        bpm: "\(report.heartRate)\nBPM",
//                                        rmssd: "\(Int(report.sdnn))\nms",
//                                        stress: report.stressLevel
                                        report: report
                                        )
                                }
                            }


                        }

                        .padding(14)
                        
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .background(Color.white)
                        .cornerRadius(16)
//                        .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 6)
                        .padding(.horizontal, 16)
//                        .padding(.bottom, 10)
                    }

//                }
            }
            .onAppear{
                viewModel.getreports(studentId: studentId)
            }
        }
    }



    func reportCard(report: Report) -> some View{
        VStack(spacing: 2){
            HStack{
                Text("Date: \(report.date ?? "--")")
                    .font(.subheadline)
                    .foregroundStyle(Color.black)

                                Spacer()
                HStack{
                    NavigationLink(destination: ReportScreen(sid: studentId, sessionid: report.sessionId),
                        label:{
                          Image(systemName: "ellipsis")
                            .font(.title)
                            .foregroundStyle(.teal)
                    })

                }

            }
            HStack(spacing: 10){
                metrichip(title: "\(report.afterQuestionBP ?? "--")\nmmHg",icon: "cuff")
//                    .frame(width: 125, height: 120)
                metrichip(
                    title: String(format: "%.2f\nbpm", report.heartRate ?? 0),
                    icon: "ppg")
//                .frame(width: 110, height: 150)
                metrichip(title: "\(Int(report.sdnn ?? 0))\nms", icon: "heart")
                    .frame(width: 100, height: 90)


            }
            .frame(maxWidth: .infinity)
//            .fixedSize(horizontal: false, vertical: true)


            HStack{
                Spacer()
                Text("Stress Level :")
                    .font(.subheadline)
                    .foregroundStyle(Color.black)
                Text(stressLevelText(report.stressLevel))
                    .font(.subheadline)
                    .foregroundStyle(teal)

                Spacer()
            }


        }
        .padding(10)
        .frame(maxWidth: .infinity)
        .background(teal.opacity(0.28))
        .cornerRadius(12)
//        .padding(.horizontal,8)
        
    }


    func metrichip(title: String, icon: String) -> some View{
        HStack(spacing: 6){
            Image(icon)
                .resizable()
                .scaledToFit()
//                .font(.footnote)
                .foregroundStyle(Color.white)
//                .frame(width: 30, height: 28)
            Text(title)
                .font(.footnote)
                .foregroundStyle(Color.white)
        }
        .frame(maxWidth: .infinity,minHeight: 60)
        .padding(.vertical,8)
        .padding(.horizontal,8)
        .background(teal)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(Color.gray.opacity(0.2),lineWidth: 1))
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
        AllReportsScreen(studentId: UserDefaults.standard.integer(forKey: "studentId"))
    }
}
