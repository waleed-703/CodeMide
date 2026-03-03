import SwiftUI

struct AdminReport: View {
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
    @StateObject private var viewModel = ReportViewModel()
    let questionId : Int = 2006
    var body: some View {
        ZStack{
            teal.ignoresSafeArea()
            if let report = viewModel.report{
                ScrollView{
                    VStack{
                        VStack{
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
        //                        .padding()
                            
                            Text("Total Student Attempts - \(report.total_attempts) ")
                                .foregroundStyle(.white)
        //                        .font(.title3)
                                .fontWeight(.semibold)
                            
                            HStack
                            {
                                Image(systemName: "clock")
                                Text("\(report.duration) mins")
                            }
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background(Color.white.opacity(0.3))
                            .clipShape(Capsule())
    //                        .foregroundStyle(.black)
                        }
                        
                        VStack(alignment: .leading){
                            
                            Text("QuestionStatement:")
                                    .foregroundStyle(teal)
                            Text("\(report.description)")
                            
                        }
                        .padding(25)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .background(.white)
                        .cornerRadius(12)
        //                .padding(.vertical,)
                        .padding(.horizontal,25)
                        
                        VStack(alignment: .leading){
                            Text("OverAll Average Stress\nWith ChatGpt")
                                .foregroundStyle(teal)
                                .font(.title2)
                                .fontWeight(.semibold)
                            HStack{
                                Text("Final Stress Level:")
                                    .foregroundStyle(teal)
                                Text(report.most_common_stress_level ?? "")
                            }
                            
                            Divider()
                                .frame(width: 250)
                            
                            Text("Blood Pressure (BP) Analysis:")
                                .foregroundStyle(teal)
                                .fontWeight(.semibold)
                                .font(.title3)
                            
                            HStack{
                                Text("Systolic / Diastolic :")
                                
                                Text("\(report.avg_bp)")
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
                                Text("\(String(format: "%.1f", viewModel.report?.avg_heart_rate ?? 0)) bpm")
                                    .foregroundStyle(teal)
                            }
                            HStack{
                                Text("SDNN :")
                                Text("\(String(format: "%.1f", viewModel.report?.avg_sdnn ?? 0)) ms")
                                    .foregroundStyle(teal)
                            }
                            HStack{
                                Text("18 ms :")
                                Text("15.6 bpm")
                                    .foregroundStyle(teal)
                            }
                            
                            Divider()
                                .frame(width: 250)
                            
                            Text("Higher RMMSD And SDNN indicate better relaxation and autonomic balance.")
                                .foregroundStyle(.gray)
                                .font(.caption)
                            
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .background(.white)
                        .cornerRadius(12)
                        .padding(.horizontal,25)
                        
                        
                        
                        
//                        VStack(alignment: .leading){
//                            Text("OverAll Average Stress\nWithout ChatGpt")
//                                .foregroundStyle(teal)
//                                .font(.title2)
//                                .fontWeight(.semibold)
//                            HStack{
//                                Text("Final Stress Level:")
//                                    .foregroundStyle(teal)
////                                Text(report.most_common_stress_level ?? "")
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
//                                Text("130/80 mmHg")
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
//                                Text("58.6 bpm")
//                                    .foregroundStyle(teal)
//                            }
//                            HStack{
//                                Text("SDNN :")
//                                Text("58.6 bpm")
//                                    .foregroundStyle(teal)
//                            }
//                            HStack{
//                                Text("18 ms :")
//                                Text("15.6 bpm")
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
                        
                        Spacer()
                    }

                }


                
            }
            
            else {
                            // Loading State
                            ProgressView("Fetching Report...")
                                .tint(.white)
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                        }
            
            


//            }
        }
        .onAppear{
            viewModel.fetchadminreport(questionId: questionId)
        }
    }
}

#Preview {
    AdminReport()
}


