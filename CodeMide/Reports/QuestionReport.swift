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
    @StateObject private var viewModel = ReportViewModel()
    @StateObject private var graphModel = GraphViewModel()
    @StateObject private var ppgViewModel = PPGViewModel()
    let question : SQuestion
    let sessionid : Int
    let sid : Int
    let qid : Int
    func bpView(
        title: String,
        value: String,
        color: Color
    ) -> some View {

        VStack(spacing: 4){

            Text(title)
                .font(.caption2)
                .bold()

            Text(value)
                .font(.caption2)
        }
        .padding(8)
        .background(color)
        .foregroundStyle(.white)
        .cornerRadius(10)
    }

    var body: some View {
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
                        Text(question.description)
                        
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
                            Text(viewModel.squestionReport?.time_taken ??
                                 "")
                        }
                        
                        HStack {
                            Text("Stress Index:")
                                .foregroundStyle(teal)
                            Text("\(viewModel.squestionReport?.SI ?? 0, specifier: "%.3f")")
                        }
                        
                        
                        Divider()
                            .frame(width: 250)
                        
                        Text("Before Question Blood Pressure:")
                            .foregroundStyle(teal)
                            .fontWeight(.semibold)
                            .font(.title3)
                        
                        HStack{
                            Text("Systolic / Diastolic :")
                            
                            Text(viewModel.squestionReport?.bpb ?? "")
                                .foregroundStyle(teal)
                        }
                        
                        Text("Mid Question Blood Pressure:")
                            .foregroundStyle(teal)
                            .fontWeight(.semibold)
                            .font(.title3)
                        
                        HStack{
                            Text("Systolic / Diastolic :")
                            
                            Text(viewModel.squestionReport?.bpm ?? "")
                                .foregroundStyle(teal)
                        }
                        
                        Text("After Question Blood Pressure:")
                            .foregroundStyle(teal)
                            .fontWeight(.semibold)
                            .font(.title3)
                        
                        HStack{
                            Text("Systolic / Diastolic :")
                            
                            Text(viewModel.squestionReport?.bpa ?? "")
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
                            Text("\(viewModel.squestionReport?.HR ?? 0, specifier: "%.3f") bpm")
                                .foregroundStyle(teal)
                        }
                        HStack{
                            Text("SDNN :")
                            Text("\(viewModel.squestionReport?.SDNN ?? 0, specifier: "%.3f") ms")
                                .foregroundStyle(teal)
                        }
                        HStack{
                            Text("RMSSD:")
                            Text("\(viewModel.squestionReport?.RMSSD ?? 0, specifier: "%.3f") ms")
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
//                                            VStack(alignment: .leading){
//                                                Text("EEG Individual Bands:")
//                                                    .foregroundStyle(teal)
//                                                    .font(.title2)
//                                                    .fontWeight(.semibold)
//                    
//                                                Text("Alpha")
//                        //                            .foregroundStyle(teal)
//                                                    .fontWeight(.semibold)
//                                                Chart(graphModel.alphapoints){point in
//                                                    LineMark(x: .value("Time", point.x), y: .value("Alpha", point.y))
//                                                }
//                                                .foregroundStyle(.orange)
//                    
//                                                Divider()
//                    
//                                                Text("Beta")
//                        //                            .foregroundStyle(teal)
//                                                    .fontWeight(.semibold)
//                                                Chart(graphModel.betapoints){point in
//                                                    LineMark(x: .value("Time", point.x), y: .value("Beta", point.y))
//                                                }
//                                                .foregroundStyle(.purple)
//                    
//                                                Divider()
//                    
//                                                Text("Theta")
//                        //                            .foregroundStyle(teal)
//                                                    .fontWeight(.semibold)
//                                                Chart(graphModel.thetapoints){point in
//                                                    LineMark(x: .value("Time", point.x), y: .value("Theta", point.y))
//                                                }
//                                                .foregroundStyle(.green)
//                    
//                                                Divider()
//                    
//                                                Text("Delta")
//                        //                            .foregroundStyle(teal)
//                                                    .fontWeight(.semibold)
//                                                Chart(graphModel.deltapoints){point in
//                                                    LineMark(x: .value("Time", point.x), y: .value("Delta", point.y))
//                                                }
//                                                .foregroundStyle(.blue)
//                    
//                                                Divider()
//                    
//                                                Text("Gamma")
//                        //                            .foregroundStyle(teal)
//                                                    .fontWeight(.semibold)
//                                                Chart(graphModel.gammapoints){point in
//                                                    LineMark(x: .value("Time", point.x), y: .value("Gamma", point.y))
//                                                }
//                                                .foregroundStyle(.red)
//                                            }
//                                            .padding(20)
//                                            .background(.gray.opacity(0.1))
//                                            .cornerRadius(12)
                                            
                                            VStack(alignment: .leading){

                                                Text("EEG Individual Bands:")
                                                    .foregroundStyle(teal)
                                                    .font(.title2)
                                                    .fontWeight(.semibold)

                                                // =====================================================
                                                // COMMON BP VIEW
                                                // =====================================================

                                            
                                                // =====================================================
                                                // ALPHA
                                                // =====================================================

                                                Text("Alpha")
                                                    .fontWeight(.semibold)

                                                Chart {

                                                    ForEach(graphModel.alphapoints){ point in

                                                        LineMark(
                                                            x: .value("Time", point.x),
                                                            y: .value("Alpha", point.y)
                                                        )
                                                        .foregroundStyle(.orange)
                                                        .lineStyle(
                                                            StrokeStyle(lineWidth: 4)
                                                        )
                                                        .interpolationMethod(.catmullRom)
                                                    }

                                                    // START
                                                    if let first = graphModel.alphapoints.first {

                                                        PointMark(
                                                            x: .value("Time", first.x),
                                                            y: .value("Alpha", first.y)
                                                        )
                                                        .foregroundStyle(.blue)
                                                        .symbolSize(90)

                                                        .annotation(position: .top) {

                                                            bpView(
                                                                title: "START",
                                                                value: viewModel.squestionReport?.bpb ?? "",
                                                                color: .blue
                                                            )
                                                        }
                                                    }

                                                    // MID
                                                    if !graphModel.alphapoints.isEmpty {

                                                        let midIndex =
                                                        graphModel.alphapoints.count / 2

                                                        PointMark(
                                                            x: .value(
                                                                "Time",
                                                                graphModel.alphapoints[midIndex].x
                                                            ),
                                                            y: .value(
                                                                "Alpha",
                                                                graphModel.alphapoints[midIndex].y
                                                            )
                                                        )
                                                        .foregroundStyle(.purple)
                                                        .symbolSize(90)

                                                        .annotation(position: .top){

                                                            bpView(
                                                                title: "MID",
                                                                value: viewModel.squestionReport?.bpm ?? "",
                                                                color: .purple
                                                            )
                                                        }
                                                    }

                                                    // END
                                                    if let last = graphModel.alphapoints.last {

                                                        PointMark(
                                                            x: .value("Time", last.x),
                                                            y: .value("Alpha", last.y)
                                                        )
                                                        .foregroundStyle(.green)
                                                        .symbolSize(90)

                                                        .annotation(position: .top){

                                                            bpView(
                                                                title: "END",
                                                                value: viewModel.squestionReport?.bpa ?? "",
                                                                color: .green
                                                            )
                                                        }
                                                    }
                                                }
                                                .chartXScale(domain: -5...140)
                                                .chartYScale(domain: 0...6)
                                                .frame(height: 300)

                                                Divider()

                                                // =====================================================
                                                // BETA
                                                // =====================================================

                                                Text("Beta")
                                                    .fontWeight(.semibold)

                                                Chart {

                                                    ForEach(graphModel.betapoints){ point in

                                                        LineMark(
                                                            x: .value("Time", point.x),
                                                            y: .value("Beta", point.y)
                                                        )
                                                        .foregroundStyle(.purple)
                                                        .lineStyle(
                                                            StrokeStyle(lineWidth: 4)
                                                        )
                                                        .interpolationMethod(.catmullRom)
                                                    }

                                                    if let first = graphModel.betapoints.first {

                                                        PointMark(
                                                            x: .value("Time", first.x),
                                                            y: .value("Beta", first.y)
                                                        )
                                                        .foregroundStyle(.blue)
                                                        .symbolSize(90)

                                                        .annotation(position: .top){

                                                            bpView(
                                                                title: "START",
                                                                value: viewModel.squestionReport?.bpb ?? "",
                                                                color: .blue
                                                            )
                                                        }
                                                    }

                                                    if !graphModel.betapoints.isEmpty {

                                                        let midIndex =
                                                        graphModel.betapoints.count / 2

                                                        PointMark(
                                                            x: .value(
                                                                "Time",
                                                                graphModel.betapoints[midIndex].x
                                                            ),
                                                            y: .value(
                                                                "Beta",
                                                                graphModel.betapoints[midIndex].y
                                                            )
                                                        )
                                                        .foregroundStyle(.purple)
                                                        .symbolSize(90)

                                                        .annotation(position: .top){

                                                            bpView(
                                                                title: "MID",
                                                                value: viewModel.squestionReport?.bpm ?? "",
                                                                color: .purple
                                                            )
                                                        }
                                                    }

                                                    if let last = graphModel.betapoints.last {

                                                        PointMark(
                                                            x: .value("Time", last.x),
                                                            y: .value("Beta", last.y)
                                                        )
                                                        .foregroundStyle(.green)
                                                        .symbolSize(90)

                                                        .annotation(position: .top){

                                                            bpView(
                                                                title: "END",
                                                                value: viewModel.squestionReport?.bpa ?? "",
                                                                color: .green
                                                            )
                                                        }
                                                    }
                                                }
                                                .chartXScale(domain: -5...140)
                                                .chartYScale(domain: 0...6)
                                                .frame(height: 300)

                                                Divider()

                                                // =====================================================
                                                // THETA
                                                // =====================================================

                                                Text("Theta")
                                                    .fontWeight(.semibold)

                                                Chart {

                                                    ForEach(graphModel.thetapoints){ point in

                                                        LineMark(
                                                            x: .value("Time", point.x),
                                                            y: .value("Theta", point.y)
                                                        )
                                                        .foregroundStyle(.green)
                                                        .lineStyle(
                                                            StrokeStyle(lineWidth: 4)
                                                        )
                                                        .interpolationMethod(.catmullRom)
                                                    }

                                                    if let first = graphModel.thetapoints.first {

                                                        PointMark(
                                                            x: .value("Time", first.x),
                                                            y: .value("Theta", first.y)
                                                        )
                                                        .foregroundStyle(.blue)
                                                        .symbolSize(90)

                                                        .annotation(position: .top){

                                                            bpView(
                                                                title: "START",
                                                                value: viewModel.squestionReport?.bpb ?? "",
                                                                color: .blue
                                                            )
                                                        }
                                                    }

                                                    if !graphModel.thetapoints.isEmpty {

                                                        let midIndex =
                                                        graphModel.thetapoints.count / 2

                                                        PointMark(
                                                            x: .value(
                                                                "Time",
                                                                graphModel.thetapoints[midIndex].x
                                                            ),
                                                            y: .value(
                                                                "Theta",
                                                                graphModel.thetapoints[midIndex].y
                                                            )
                                                        )
                                                        .foregroundStyle(.purple)
                                                        .symbolSize(90)

                                                        .annotation(position: .top){

                                                            bpView(
                                                                title: "MID",
                                                                value: viewModel.squestionReport?.bpm ?? "",
                                                                color: .purple
                                                            )
                                                        }
                                                    }

                                                    if let last = graphModel.thetapoints.last {

                                                        PointMark(
                                                            x: .value("Time", last.x),
                                                            y: .value("Theta", last.y)
                                                        )
                                                        .foregroundStyle(.green)
                                                        .symbolSize(90)

                                                        .annotation(position: .top){

                                                            bpView(
                                                                title: "END",
                                                                value: viewModel.squestionReport?.bpa ?? "",
                                                                color: .green
                                                            )
                                                        }
                                                    }
                                                }
                                                .chartXScale(domain: -5...140)
                                                .chartYScale(domain: 0...6)
                                                .frame(height: 300)

                                                Divider()

                                                // =====================================================
                                                // DELTA
                                                // =====================================================

                                                Text("Delta")
                                                    .fontWeight(.semibold)

                                                Chart {

                                                    ForEach(graphModel.deltapoints){ point in

                                                        LineMark(
                                                            x: .value("Time", point.x),
                                                            y: .value("Delta", point.y)
                                                        )
                                                        .foregroundStyle(.blue)
                                                        .lineStyle(
                                                            StrokeStyle(lineWidth: 4)
                                                        )
                                                        .interpolationMethod(.catmullRom)
                                                    }

                                                    if let first = graphModel.deltapoints.first {

                                                        PointMark(
                                                            x: .value("Time", first.x),
                                                            y: .value("Delta", first.y)
                                                        )
                                                        .foregroundStyle(.blue)
                                                        .symbolSize(90)

                                                        .annotation(position: .top){

                                                            bpView(
                                                                title: "START",
                                                                value: viewModel.squestionReport?.bpb ?? "",
                                                                color: .blue
                                                            )
                                                        }
                                                    }

                                                    if !graphModel.deltapoints.isEmpty {

                                                        let midIndex =
                                                        graphModel.deltapoints.count / 2

                                                        PointMark(
                                                            x: .value(
                                                                "Time",
                                                                graphModel.deltapoints[midIndex].x
                                                            ),
                                                            y: .value(
                                                                "Delta",
                                                                graphModel.deltapoints[midIndex].y
                                                            )
                                                        )
                                                        .foregroundStyle(.purple)
                                                        .symbolSize(90)

                                                        .annotation(position: .top){

                                                            bpView(
                                                                title: "MID",
                                                                value: viewModel.squestionReport?.bpm ?? "",
                                                                color: .purple
                                                            )
                                                        }
                                                    }

                                                    if let last = graphModel.deltapoints.last {

                                                        PointMark(
                                                            x: .value("Time", last.x),
                                                            y: .value("Delta", last.y)
                                                        )
                                                        .foregroundStyle(.green)
                                                        .symbolSize(90)

                                                        .annotation(position: .top){

                                                            bpView(
                                                                title: "END",
                                                                value: viewModel.squestionReport?.bpa ?? "",
                                                                color: .green
                                                            )
                                                        }
                                                    }
                                                }
                                                .chartXScale(domain: -5...140)
                                                .chartYScale(domain: 0...6)
                                                .frame(height: 300)

                                                Divider()

                                                // =====================================================
                                                // GAMMA
                                                // =====================================================

                                                Text("Gamma")
                                                    .fontWeight(.semibold)

                                                Chart {

                                                    ForEach(graphModel.gammapoints){ point in

                                                        LineMark(
                                                            x: .value("Time", point.x),
                                                            y: .value("Gamma", point.y)
                                                        )
                                                        .foregroundStyle(.red)
                                                        .lineStyle(
                                                            StrokeStyle(lineWidth: 4)
                                                        )
                                                        .interpolationMethod(.catmullRom)
                                                    }

                                                    if let first = graphModel.gammapoints.first {

                                                        PointMark(
                                                            x: .value("Time", first.x),
                                                            y: .value("Gamma", first.y)
                                                        )
                                                        .foregroundStyle(.blue)
                                                        .symbolSize(90)

                                                        .annotation(position: .top){

                                                            bpView(
                                                                title: "START",
                                                                value: viewModel.squestionReport?.bpb ?? "",
                                                                color: .blue
                                                            )
                                                        }
                                                    }

                                                    if !graphModel.gammapoints.isEmpty {

                                                        let midIndex =
                                                        graphModel.gammapoints.count / 2

                                                        PointMark(
                                                            x: .value(
                                                                "Time",
                                                                graphModel.gammapoints[midIndex].x
                                                            ),
                                                            y: .value(
                                                                "Gamma",
                                                                graphModel.gammapoints[midIndex].y
                                                            )
                                                        )
                                                        .foregroundStyle(.purple)
                                                        .symbolSize(90)

                                                        .annotation(position: .top){

                                                            bpView(
                                                                title: "MID",
                                                                value: viewModel.squestionReport?.bpm ?? "",
                                                                color: .purple
                                                            )
                                                        }
                                                    }

                                                    if let last = graphModel.gammapoints.last {

                                                        PointMark(
                                                            x: .value("Time", last.x),
                                                            y: .value("Gamma", last.y)
                                                        )
                                                        .foregroundStyle(.green)
                                                        .symbolSize(90)

                                                        .annotation(position: .top){

                                                            bpView(
                                                                title: "END",
                                                                value: viewModel.squestionReport?.bpa ?? "",
                                                                color: .green
                                                            )
                                                        }
                                                    }
                                                }
                                                .chartXScale(domain: -5...140)
                                                .chartYScale(domain: 0...6)
                                                .frame(height: 300)
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
                    
                   
                    
                    VStack() {
                        
                        Text("PPG (Heart Rate Variability)")
                            .foregroundStyle(teal)
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        Chart(ppgViewModel.questionPPGPoints) { point in
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
                        
                        Text("Time (index)")
                            .font(.caption)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("PPG Metrics:")
                                .foregroundStyle(teal)
                                .fontWeight(.semibold)
                            
                            Text("HR -> Heart Rate")
                                .foregroundStyle(.gray)
                            
                            Text("SDNN -> Variability")
                                .foregroundStyle(.gray)
                            
                            Text("RMSSD -> Recovery")
                                .foregroundStyle(.gray)
                            
                            Text("pNN50 -> Parasympathetic")
                                .foregroundStyle(.gray)
                        }
                    }
                    .padding(20)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .background(.white)
                    .cornerRadius(12)
                    //                    .padding(.vertical,5)
                    .padding(.horizontal,25)
                    
                    Spacer()
                }
                
                .onAppear{
                    viewModel.getqstudentreport(sid : sid, qid :qid)
                    graphModel.gethetadata(sessionid: String(sessionid), sid: String(sid), qid: String(qid))
                    graphModel.getbetadata(sessionid: String(sessionid), sid: String(sid), qid: String(qid))
                    graphModel.getalphadata(sessionid: String(sessionid), sid: String(sid), qid: String(qid))
                    graphModel.getdeltadata(sessionid: String(sessionid), sid: String(sid), qid: String(qid))
                    graphModel.getgammadata(sessionid: String(sessionid), sid: String(sid), qid: String(qid))
                    ppgViewModel.getSinglePPG(
                        sessionID: String(sessionid),
                        sid: String(sid),
                        qid: String(qid)
                    )
                    
                    
                    graphModel.getCombinedQuestionData(
                        sessionid: String(sessionid),
                        sid: String(sid)
                    )
                }
                
            }
            
        }
        

    }
}

#Preview {
    QuestionReport(question: SQuestion(qid: 0, description: ""),sessionid: 0,sid :1000, qid: 2004)
}


