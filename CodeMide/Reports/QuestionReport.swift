import SwiftUI
import Charts

struct graphdata : Identifiable{
    let id = UUID()
    let x : Double
    let y : Double
    let band : String
}
struct QuestionReport: View {
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
    var body: some View {
        let eeg : [graphdata] = [
            .init(x: 6, y: 6.5, band: "Alpha"),
            
            .init(x: 0.1, y: 0.40, band: "Beta"),
            
            .init(x: 0.1, y: 0.30, band: "Theta"),
            
            .init(x: 0.1, y: 0.20, band: "Gamma"),
            
            .init(x: 0.1, y: 0.15, band: "Delta")
            
        ]
        ZStack{
            teal.ignoresSafeArea()
            
            VStack{
                ScrollView{
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
                    }
                    
                    VStack(alignment: .leading){
                        
                        Text("QuestionStatement:")
                            .foregroundStyle(teal)
                        Text("Write a C/C++ Program That performs and displays arithmetic operations using both integer and floating point numbers.")
                        
                    }
                    .padding(20)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading)
                    .background(.white)
                    .cornerRadius(12)
                    //                .padding(.vertical,)
                    .padding(.horizontal,25)
                    
                    VStack(alignment: .leading){
                        Text("OverAll Stress")
                            .foregroundStyle(teal)
                            .font(.title2)
                            .fontWeight(.semibold)
                    
                        HStack{
                            Text("Final Stress Level:")
                                .foregroundStyle(teal)
                            Text("High")
                        }
                        
                        HStack {
                            Text("Complete Time:")
                                .foregroundStyle(teal)
                            Text("8min, 08 sec")
                        }
                        
                        Divider()
                            .frame(width: 250)
                        
                        Text("Blood Pressure (BP) Analysis:")
                            .foregroundStyle(teal)
                            .fontWeight(.semibold)
                            .font(.title3)
                        
                        HStack{
                            Text("Systolic / Diastolic :")
                            
                            Text("130/80 mmHg")
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
                            Text("58.6 bpm")
                                .foregroundStyle(teal)
                        }
                        HStack{
                            Text("SDNN :")
                            Text("18 ms")
                                .foregroundStyle(teal)
                        }
                        HStack{
                            Text("RMSSD:")
                            Text("15.8 ms")
                                .foregroundStyle(teal)
                        }
                        
                        Divider()
                            .frame(width: 250)
                        
                        Text("Higher RMMSD And SDNN indicate better relaxation and autonomic balance.")
                            .foregroundStyle(.gray)
                            .font(.caption)
                        
                    }
                    .padding(20)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,alignment: .leading)
                    .background(.white)
                    .cornerRadius(12)
//                    .padding(.vertical,5)
                    .padding(.horizontal,25)
                    
                    VStack(alignment: .leading){
                        VStack(alignment: .leading){
                            Text("EEG Individual Bands:")
                                .foregroundStyle(teal)
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Text("Alpha")
    //                            .foregroundStyle(teal)
                                .fontWeight(.semibold)
                            Chart(eeg){
                                LineMark(x: .value("Magnitude", $0.x), y: .value("Time", $0.y))
                            }
                            
                            Divider()
                            
                            Text("Beta")
    //                            .foregroundStyle(teal)
                                .fontWeight(.semibold)
                            Chart(eeg){
                                LineMark(x: .value("Magnitude", $0.x), y: .value("Time", $0.y))
                            }
                            
                            Text("Theta")
    //                            .foregroundStyle(teal)
                                .fontWeight(.semibold)
                            Chart(eeg){
                                LineMark(x: .value("Magnitude", $0.x), y: .value("Time", $0.y))
                            }
                            
                            Divider()
                            
                            Text("Delta")
    //                            .foregroundStyle(teal)
                                .fontWeight(.semibold)
                            Chart(eeg){
                                LineMark(x: .value("Magnitude", $0.x), y: .value("Time", $0.y))
                            }
                            
                            Text("Gamma")
    //                            .foregroundStyle(teal)
                                .fontWeight(.semibold)
                            Chart(eeg){
                                LineMark(x: .value("Magnitude", $0.x), y: .value("Time", $0.y))
                            }
                        }
                        .padding(20)
                        .background(.gray.opacity(0.1))
                        .cornerRadius(12)
                        
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .background(.white)
                    .cornerRadius(12)
//                    .padding(.vertical,5)
                    .padding(.horizontal,25)
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    QuestionReport()
}


