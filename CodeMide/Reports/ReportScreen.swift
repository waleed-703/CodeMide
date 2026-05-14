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
    @State private var selectedBand = "All Bands"

    let bandOptions = [
        "All Bands",
        "Alpha",
        "Beta",
        "Theta",
        "Gamma",
        "Delta"
    ]

    let bandColors: [String: Color] = [

        "Alpha": .orange,
        "Beta": .purple,
        "Theta": .green,
        "Gamma": .red,
        "Delta": .blue
    ]
    
    @State private var selectedPPGBand = "All"

    let ppgOptions = [
        "All",
        "HR",
        "SDNN",
        "RMSSD",
        "PNN50"
    ]
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
                                    Text("\(viewModel.sessionReport?.total_minutes ?? 0) min")
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
                                    
                                    Text("Mid Question Blood Pressure:")
                                        .foregroundStyle(teal)
                                        .fontWeight(.semibold)
                                        .font(.title3)
                                    
                                    HStack{
                                        Text("Systolic / Diastolic:")
                                        
                                        Text("\(viewModel.sessionReport?.average_bpm ?? "" ) mmHg")
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
//                                        .frame(width: 250)
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
                            
                            
//                            VStack(alignment: .leading){
//                                Text("Physiological Signals During Session")
//                                    .font(.title3)
//                                    .fontWeight(.semibold)
//                                    .foregroundStyle(.teal)
//                                
//                                VStack{
//                                    Text("EEG Bands Power Across Time")
//                                        .font(.caption)
//                                    Chart(eegviewModel.points){point in
//                                        LineMark(x: .value("Time",point.x),
//                                                 y: .value("Value",point.y)
//                                        )
//                                        .foregroundStyle(by: .value("Band", point.bandtype))
//                                    }
//                                    .chartYAxis {
//                                        AxisMarks(position: .leading)
//                                    }
//                                    .overlay(alignment: .leading) {
//                                        Text("Power")
//                                            .font(.caption)
////                                            .foregroundColor(.gray)
//                                            .rotationEffect(.degrees(-90))
//                                            .offset(x: -35)
//                                    }
//                                    .frame(height: 200)
//                                    .padding(.leading)
//                                    Text("Time(seconds)")
//                                        .font(.caption)
//                                    
//                                    VStack(alignment: .leading ,spacing: 5){
//                                        Text("EEG Power Bands Summary:")
//                                            .foregroundStyle(teal)
//                                            .fontWeight(.semibold)
//                                        Text("Alpha Power -> Relxation")
//                                            .foregroundStyle(.gray)
//                                        Text("Beta Power -> Focus / Stress")
//                                            .foregroundStyle(.gray)
//                                        Text("Theta -> Mental Workload")
//                                            .foregroundStyle(.gray)
//                                    }
//                                }
//                            }
//                            .padding(20)
//                            .background(.white)
//                            .cornerRadius(12)
                            
                            // =====================================================
                            // EEG SECTION
                            // =====================================================

                            VStack(alignment: .leading){

                                // =====================================================
                                // ORIGINAL EEG GRAPH
                                // =====================================================

                                Text("Physiological Signals During Session")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.teal)

                                VStack{

                                    Text("EEG Bands Power Across Time")
                                        .font(.caption)

                                    Chart(eegviewModel.points){ point in

                                        LineMark(
                                            x: .value("Time", point.x),
                                            y: .value("Value", point.y)
                                        )
                                        .foregroundStyle(
                                            by: .value(
                                                "Band",
                                                point.bandtype
                                            )
                                        )
                                    }

                                    .chartForegroundStyleScale([
                                        "delta": .blue,
                                        "theta": .green,
                                        "alpha": .orange,
                                        "beta": .purple,
                                        "gamma": .red
                                    ])

                                    .chartYAxis {
                                        AxisMarks(position: .leading)
                                    }

                                    .overlay(alignment: .leading) {

                                        Text("Power")
                                            .font(.caption)
                                            .rotationEffect(.degrees(-90))
                                            .offset(x: -35)
                                    }

                                    .frame(height: 220)
                                    .padding(.leading)

                                    Text("Time(seconds)")
                                        .font(.caption)

                                    VStack(alignment: .leading ,spacing: 5){

                                        Text("EEG Power Bands Summary:")
                                            .foregroundStyle(teal)
                                            .fontWeight(.semibold)

                                        Text("Alpha Power -> Relaxation")
                                            .foregroundStyle(.gray)

                                        Text("Beta Power -> Focus / Stress")
                                            .foregroundStyle(.gray)

                                        Text("Theta -> Mental Workload")
                                            .foregroundStyle(.gray)
                                    }
                                }

                                Divider()
                                    .padding(.vertical)

                                // =====================================================
                                // QUESTION WISE GRAPH
                                // =====================================================

                                Text("Question Wise Graphs with Blood Pressure")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundStyle(teal)

                                if eegviewModel.combinedQuestions.isEmpty {

                                    Text("No Question Graph Data")
                                        .foregroundStyle(.gray)

                                } else {

                                    ForEach(
                                        Array(
                                            eegviewModel.combinedQuestions.enumerated()
                                        ),
                                        id: \.offset
                                    ) { idx, question in

                                        VStack(alignment: .leading, spacing: 16){

                                            Text("Question \(idx + 1)")
                                                .font(.title2)
                                                .fontWeight(.bold)

                                            // =================================================
                                            // PICKER
                                            // =================================================

                                            Picker(
                                                "Band",
                                                selection: $selectedBand
                                            ) {

                                                Text("All Bands")
                                                    .tag("All Bands")

                                                Text("Alpha")
                                                    .tag("Alpha")

                                                Text("Beta")
                                                    .tag("Beta")

                                                Text("Theta")
                                                    .tag("Theta")

                                                Text("Gamma")
                                                    .tag("Gamma")

                                                Text("Delta")
                                                    .tag("Delta")
                                            }
                                            .pickerStyle(.menu)

                                            // =================================================
                                            // LEGEND
                                            // =================================================

                                            HStack(spacing: 12){

                                                Label("Alpha", systemImage: "circle.fill")
                                                    .foregroundStyle(.orange)

                                                Label("Beta", systemImage: "circle.fill")
                                                    .foregroundStyle(.purple)

                                                Label("Theta", systemImage: "circle.fill")
                                                    .foregroundStyle(.green)

                                                Label("Gamma", systemImage: "circle.fill")
                                                    .foregroundStyle(.red)

                                                Label("Delta", systemImage: "circle.fill")
                                                    .foregroundStyle(.blue)
                                            }
                                            .font(.caption)

                                            // =================================================
                                            // GRAPH
                                            // =================================================

                                            Chart {

                                                // =================================================
                                                // DELTA = BLUE
                                                // =================================================

                                                if selectedBand == "All Bands"
                                                    || selectedBand == "Delta" {

                                                    ForEach(
                                                        Array(
                                                            zip(
                                                                question.eeg.time,
                                                                question.eeg.delta
                                                            )
                                                        ),
                                                        id: \.0
                                                    ) { time, value in

                                                        LineMark(
                                                            x: .value("Time", time),
                                                            y: .value("Value", value)
                                                        )
                                                        .foregroundStyle(.blue)
                                                        .lineStyle(
                                                            StrokeStyle(lineWidth: 3)
                                                        )
                                                        .interpolationMethod(.catmullRom)
                                                    }
                                                }

                                                // =================================================
                                                // THETA = GREEN
                                                // =================================================

                                                if selectedBand == "All Bands"
                                                    || selectedBand == "Theta" {

                                                    ForEach(
                                                        Array(
                                                            zip(
                                                                question.eeg.time,
                                                                question.eeg.theta
                                                            )
                                                        ),
                                                        id: \.0
                                                    ) { time, value in

                                                        LineMark(
                                                            x: .value("Time", time),
                                                            y: .value("Value", value)
                                                        )
                                                        .foregroundStyle(.green)
                                                        .lineStyle(
                                                            StrokeStyle(lineWidth: 3)
                                                        )
                                                        .interpolationMethod(.catmullRom)
                                                    }
                                                }

                                                // =================================================
                                                // ALPHA = ORANGE
                                                // =================================================

                                                if selectedBand == "All Bands"
                                                    || selectedBand == "Alpha" {

                                                    ForEach(
                                                        Array(
                                                            zip(
                                                                question.eeg.time,
                                                                question.eeg.alpha
                                                            )
                                                        ),
                                                        id: \.0
                                                    ) { time, value in

                                                        LineMark(
                                                            x: .value("Time", time),
                                                            y: .value("Value", value)
                                                        )
                                                        .foregroundStyle(.orange)
                                                        .lineStyle(
                                                            StrokeStyle(lineWidth: 3)
                                                        )
                                                        .interpolationMethod(.catmullRom)
                                                    }
                                                }

                                                // =================================================
                                                // BETA = PURPLE
                                                // =================================================

                                                if selectedBand == "All Bands"
                                                    || selectedBand == "Beta" {

                                                    ForEach(
                                                        Array(
                                                            zip(
                                                                question.eeg.time,
                                                                question.eeg.beta
                                                            )
                                                        ),
                                                        id: \.0
                                                    ) { time, value in

                                                        LineMark(
                                                            x: .value("Time", time),
                                                            y: .value("Value", value)
                                                        )
                                                        .foregroundStyle(.purple)
                                                        .lineStyle(
                                                            StrokeStyle(lineWidth: 3)
                                                        )
                                                        .interpolationMethod(.catmullRom)
                                                    }
                                                }

                                                // =================================================
                                                // GAMMA = RED
                                                // =================================================

                                                if selectedBand == "All Bands"
                                                    || selectedBand == "Gamma" {

                                                    ForEach(
                                                        Array(
                                                            zip(
                                                                question.eeg.time,
                                                                question.eeg.gamma
                                                            )
                                                        ),
                                                        id: \.0
                                                    ) { time, value in

                                                        LineMark(
                                                            x: .value("Time", time),
                                                            y: .value("Value", value)
                                                        )
                                                        .foregroundStyle(.red)
                                                        .lineStyle(
                                                            StrokeStyle(lineWidth: 3)
                                                        )
                                                        .interpolationMethod(.catmullRom)
                                                    }
                                                }

                                                // =================================================
                                                // START BP
                                                // =================================================

                                                if question.bp.count > 0 {

                                                    PointMark(
                                                        x: .value("Time", 10),
                                                        y: .value(
                                                            "Value",
                                                            question.eeg.alpha.first ?? 0
                                                        )
                                                    )
                                                    .foregroundStyle(.blue)

                                                    .annotation(position: .topLeading){

                                                        VStack(spacing: 2){

                                                            Text("START")
                                                                .bold()

                                                            Text(
                                                                "\(Int(question.bp[0].SYS))/\(Int(question.bp[0].DIA))"
                                                            )
                                                        }
                                                        .font(.caption2)
                                                        .padding(8)
                                                        .background(.blue)
                                                        .foregroundStyle(.white)
                                                        .cornerRadius(10)
                                                    }
                                                }

                                                // =================================================
                                                // MID BP
                                                // =================================================

                                                if question.bp.count > 1 {

                                                    let midIndex =
                                                    question.eeg.time.count / 2

                                                    PointMark(
                                                        x: .value(
                                                            "Time",
                                                            question.eeg.time[midIndex]
                                                        ),
                                                        y: .value(
                                                            "Value",
                                                            question.eeg.alpha[midIndex]
                                                        )
                                                    )
                                                    .foregroundStyle(.purple)

                                                    .annotation(position: .top){

                                                        VStack(spacing: 2){

                                                            Text("MID")
                                                                .bold()

                                                            Text(
                                                                "\(Int(question.bp[1].SYS))/\(Int(question.bp[1].DIA))"
                                                            )
                                                        }
                                                        .font(.caption2)
                                                        .padding(8)
                                                        .background(.purple)
                                                        .foregroundStyle(.white)
                                                        .cornerRadius(10)
                                                    }
                                                }

                                                // =================================================
                                                // END BP
                                                // =================================================

                                                if question.bp.count > 2 {

                                                    let endIndex =
                                                    max(
                                                        question.eeg.time.count - 10,
                                                        0
                                                    )

                                                    PointMark(
                                                        x: .value(
                                                            "Time",
                                                            question.eeg.time[endIndex]
                                                        ),
                                                        y: .value(
                                                            "Value",
                                                            question.eeg.alpha[endIndex]
                                                        )
                                                    )
                                                    .foregroundStyle(.green)

                                                    .annotation(position: .topTrailing){

                                                        VStack(spacing: 2){

                                                            Text("END")
                                                                .bold()

                                                            Text(
                                                                "\(Int(question.bp[2].SYS))/\(Int(question.bp[2].DIA))"
                                                            )
                                                        }
                                                        .font(.caption2)
                                                        .padding(8)
                                                        .background(.green)
                                                        .foregroundStyle(.white)
                                                        .cornerRadius(10)
                                                    }
                                                }
                                            }

                                            .chartYAxis {
                                                AxisMarks(position: .leading)
                                            }

                                            .chartXScale(domain: -5...135)

                                            .overlay(alignment: .leading) {

                                                Text("Power")
                                                    .font(.caption)
                                                    .rotationEffect(.degrees(-90))
                                                    .offset(x: -35)
                                            }

                                            .frame(height: 320)

                                            Text("Time(seconds)")
                                                .font(.caption)
                                        }
                                        .padding()
                                        .background(.gray.opacity(0.05))
                                        .cornerRadius(12)
                                    }
                                }
                            }
                            .padding(20)
                            .background(.white)
                            .cornerRadius(12)
                            
//                            VStack {
//                                Text("PPG (Heart Rate Variability) Over Time")
//                                    .font(.caption)
//
//                                Chart(ppgViewModel.ppgPoints) { point in
//                                    LineMark(
//                                        x: .value("Time", point.x),
//                                        y: .value("Value", point.y)
//                                    )
//                                    .foregroundStyle(by: .value("Type", point.type))
//                                }
//                                .chartYAxis {
//                                    AxisMarks(position: .leading)
//                                }
//                                .overlay(alignment: .leading) {
//                                    Text("Value")
//                                        .font(.caption)
//                                        .rotationEffect(.degrees(-90))
//                                        .offset(x: -35)
//                                }
//                                .frame(height: 200)
//                                .padding(.leading)
//
//                                Text("Time(seconds)")
//                                    .font(.caption)
//
//                                VStack(alignment: .leading, spacing: 5) {
//                                    Text("PPG Metrics:")
//                                        .foregroundStyle(teal)
//                                        .fontWeight(.semibold)
//
//                                    Text("HR -> Heart Rate")
//                                        .foregroundStyle(.gray)
//
//                                    Text("SDNN -> HR Variability")
//                                        .foregroundStyle(.gray)
//
//                                    Text("RMSSD -> Parasympathetic Activity")
//                                        .foregroundStyle(.gray)
//                                    Text("pNN50 -> Parasympathetic Balance")
//                                        .foregroundStyle(.gray)
//                                }
//                            }
//                            .padding(20)
//                            .background(.white)
//                            .cornerRadius(12)
                            
                            // =====================================================
                            // PPG GRAPH
                            // =====================================================

                  

                            VStack {

                                Text("PPG (Heart Rate Variability) Over Time")
                                    .font(.caption)

                                // =================================================
                                // DROPDOWN
                                // =================================================

                                Picker(
                                    "PPG Type",
                                    selection: $selectedPPGBand
                                ) {

                                    Text("All")
                                        .tag("All")

                                    Text("HR")
                                        .tag("HR")

                                    Text("SDNN")
                                        .tag("SDNN")

                                    Text("RMSSD")
                                        .tag("RMSSD")

                                    Text("PNN50")
                                        .tag("PNN50")
                                }
                                .pickerStyle(.menu)

                                // =================================================
                                // LEGEND
                                // =================================================

                                HStack(spacing: 12){

                                    Label("HR", systemImage: "circle.fill")
                                        .foregroundStyle(.blue)

                                    Label("SDNN", systemImage: "circle.fill")
                                        .foregroundStyle(.green)

                                    Label("RMSSD", systemImage: "circle.fill")
                                        .foregroundStyle(.orange)

                                    Label("PNN50", systemImage: "circle.fill")
                                        .foregroundStyle(.purple)
                                }
                                .font(.caption)

                                // =================================================
                                // CHART
                                // =================================================

                                Chart(ppgViewModel.ppgPoints) { point in

                                    // =================================================
                                    // ALL BANDS
                                    // =================================================

                                    if selectedPPGBand == "All" {

                                        LineMark(
                                            x: .value("Time", point.x),
                                            y: .value("Value", point.y)
                                        )
                                        .foregroundStyle(
                                            by: .value(
                                                "Type",
                                                point.type.uppercased()
                                            )
                                        )
                                        .lineStyle(
                                            StrokeStyle(lineWidth: 3)
                                        )
                                        .interpolationMethod(.catmullRom)
                                    }

                                    // =================================================
                                    // HR
                                    // =================================================

                                    else if selectedPPGBand == "HR"
                                                && point.type.lowercased() == "hr" {

                                        LineMark(
                                            x: .value("Time", point.x),
                                            y: .value("Value", point.y)
                                        )
                                        .foregroundStyle(.blue)
                                        .lineStyle(
                                            StrokeStyle(lineWidth: 3)
                                        )
                                        .interpolationMethod(.catmullRom)
                                    }

                                    // =================================================
                                    // SDNN
                                    // =================================================

                                    else if selectedPPGBand == "SDNN"
                                                && point.type.lowercased() == "sdnn" {

                                        LineMark(
                                            x: .value("Time", point.x),
                                            y: .value("Value", point.y)
                                        )
                                        .foregroundStyle(.green)
                                        .lineStyle(
                                            StrokeStyle(lineWidth: 3)
                                        )
                                        .interpolationMethod(.catmullRom)
                                    }

                                    // =================================================
                                    // RMSSD
                                    // =================================================

                                    else if selectedPPGBand == "RMSSD"
                                                && point.type.lowercased() == "rmssd" {

                                        LineMark(
                                            x: .value("Time", point.x),
                                            y: .value("Value", point.y)
                                        )
                                        .foregroundStyle(.orange)
                                        .lineStyle(
                                            StrokeStyle(lineWidth: 3)
                                        )
                                        .interpolationMethod(.catmullRom)
                                    }

                                    // =================================================
                                    // PNN50
                                    // =================================================

                                    else if selectedPPGBand == "PNN50"
                                                && point.type.lowercased() == "pnn50" {

                                        LineMark(
                                            x: .value("Time", point.x),
                                            y: .value("Value", point.y)
                                        )
                                        .foregroundStyle(.purple)
                                        .lineStyle(
                                            StrokeStyle(lineWidth: 3)
                                        )
                                        .interpolationMethod(.catmullRom)
                                    }
                                }

                                .chartForegroundStyleScale([
                                    "HR": .blue,
                                    "SDNN": .green,
                                    "RMSSD": .orange,
                                    "PNN50": .purple
                                ])

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

//                            VStack(alignment: .leading, spacing: 4){
//                                Text("Self Report:")
//                                    .foregroundStyle(teal)
//                                    .fontWeight(.bold)
//                                    .font(.title3)
//                                
//                                HStack{
//                                    Text("Mental Load:")
//                                    Text("\(viewModel.selfReport?.mentalLoad ?? 0)")
//                                        .foregroundStyle(teal)
//                                }
//                                HStack{
//                                    Text("Frustration:")
//                                    Text("\(viewModel.selfReport?.frustration ?? 0)")
//                                        .foregroundStyle(teal)
//                                }
//                                HStack{
//                                    Text("Effort:")
//                                    Text("\(viewModel.selfReport?.effort ?? 0)")
//                                        .foregroundStyle(teal)
//                                }
//                                HStack{
//                                    Text("Comments:")
//                                    Text("\(viewModel.selfReport?.comment ?? "")")
//                                        .foregroundStyle(teal)
//                                }
//                            }
//                            .padding(10)
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .background(.white)
//                            .cornerRadius(12)
                            
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
//                            eegviewModel.getgraphdata(sessionid: String(sessionid), sid: String(sid))
                            ppgViewModel.getAllPPG(sessionID: String(sessionid), sid: String(sid))
                            viewModel.getselfreport(sessionid: sessionid)
                            eegviewModel.getgraphdata(
                                sessionid: String(sessionid),
                                sid: String(sid)
                            )

                            eegviewModel.getCombinedQuestionData(
                                sessionid: String(sessionid),
                                sid: String(sid)
                            )
                        }
//                        .task {
//                            viewModel.getselfreport(sessionid: sessionid)
//                        }
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
