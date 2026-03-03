import SwiftUI
import Charts

struct eegdata : Identifiable{
    let id = UUID()
    let x : Double
    let y : Double
    let bandtype : String
}

struct ReportScreen: View {
    @Environment(\.dismiss) var dismiss
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
//    var stressvalue : Double
    let eeg : [eegdata] = [
        // Alpha (reduced & unstable in stress)
            .init(x: 0.1, y: 0.65, bandtype: "Alpha"),
            .init(x: 0.3, y: 0.30, bandtype: "Alpha"),
            .init(x: 0.5, y: 0.55, bandtype: "Alpha"),
            .init(x: 0.7, y: 0.25, bandtype: "Alpha"),
            .init(x: 0.9, y: 0.45, bandtype: "Alpha"),

            // Beta (high & spiky in stress)
            .init(x: 0.1, y: 0.40, bandtype: "Beta"),
            .init(x: 0.3, y: 0.85, bandtype: "Beta"),
            .init(x: 0.5, y: 0.35, bandtype: "Beta"),
            .init(x: 0.7, y: 0.90, bandtype: "Beta"),
            .init(x: 0.9, y: 0.50, bandtype: "Beta"),

            // Theta (moderate but fluctuating)
            .init(x: 0.1, y: 0.30, bandtype: "Theta"),
            .init(x: 0.3, y: 0.55, bandtype: "Theta"),
            .init(x: 0.5, y: 0.25, bandtype: "Theta"),
            .init(x: 0.7, y: 0.60, bandtype: "Theta"),
            .init(x: 0.9, y: 0.35, bandtype: "Theta"),

            // Gamma (sharp spikes → anxiety / cognitive overload)
            .init(x: 0.1, y: 0.20, bandtype: "Gamma"),
            .init(x: 0.3, y: 0.75, bandtype: "Gamma"),
            .init(x: 0.5, y: 0.30, bandtype: "Gamma"),
            .init(x: 0.7, y: 0.85, bandtype: "Gamma"),
            .init(x: 0.9, y: 0.40, bandtype: "Gamma"),

            // Delta (low in awake stressed state)
            .init(x: 0.1, y: 0.15, bandtype: "Delta"),
            .init(x: 0.3, y: 0.10, bandtype: "Delta"),
            .init(x: 0.5, y: 0.20, bandtype: "Delta"),
            .init(x: 0.7, y: 0.12, bandtype: "Delta"),
            .init(x: 0.9, y: 0.18, bandtype: "Delta")

        
    ]
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
                            
                            Text("Waleed Ahmed!")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                            Text("8th Semester")
                                .font(.title2)
//                                .fontWeight(.semibold)
                                .foregroundStyle(.white)

                            VStack(alignment:.leading,spacing: 6){
                                Text("Over All Stress & Performance Summary")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.teal)
                                
                                HStack {
                                    Text("Final Stress Level")
                                        .foregroundStyle(teal)
                                    Text("High")
                                }
                                
                                HStack{
                                    Text("Cognitive Load:")
                                        .foregroundStyle(teal)
                                    Text("High")
                                }
                                HStack{
                                    Text("Date:")
                                        .foregroundStyle(.teal)
                                    Text("Dec 23, 2025")
                                    
                                }
                                HStack{
                                    Text("Complete Time:")
                                        .foregroundStyle(.teal)
                                    Text("8min, 07 sec")
                                }
                                
                                Divider()
                                    .frame(width: 250)
                                VStack(alignment: .leading,spacing: 6){
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
                                        Text("RMSSD :")
                                        Text("15.6 ms")
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
                                    Chart(eeg){
                                        LineMark(x: .value("Time",$0.x),
                                                 y: .value("Band",$0.y)
                                        )
                                        .foregroundStyle(by: .value("Band", $0.bandtype))
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
                            
                            
                            VStack(alignment: .leading){
                                Text("Reports Of Each Question")
                                    .foregroundStyle(teal)
                                    .fontWeight(.bold)
//                                    .font(.title2)
                                
                                ForEach(0...2,id: \.self){index in
                                    VStack(){
                                        VStack(alignment: .leading) {
                                        Text("Q01:")
                                            .foregroundStyle(.white)
                                            .fontWeight(.semibold)
                                        
                                        Text("Write A C++ Program That Performs And Display Arithmetic Operations\nUsing Both Integers and Floating-Point Data Types ")
                                            .foregroundStyle(.white)
                                    }
                                    
                                    
                                    
                                    NavigationLink{
                                        QuestionReport()
                                    }label: {
                                        Image(systemName: "doc.on.clipboard.fill")
                                        Text("Report")
                                            .font(.subheadline)
                                    }
                                    .padding(.horizontal,12)
                                    .padding(.vertical,6)
                                    //                    .frame(maxWidth: .infinity)
                                    .foregroundStyle(teal)
                                    .background(Color.white)
                                    .clipShape(Capsule())
                                    
                                }
                                    }
                                    .padding(20)
                                    .background(teal)
                                    .cornerRadius(12)
//                                    .padding(.vertical,20)
//                                    .padding(.horizontal,12)
                                
                                    
//                                }
                            }
                            .padding(20)
//                            .padding(.vertical,20)
                            .background(.white)
                            .cornerRadius(12)
                            .padding(.horizontal,1)
                        }
                        .padding()
                        
                    }
                }
             
            }
        }
    }

}

#Preview {
    NavigationStack{
        ReportScreen()
    }
}
