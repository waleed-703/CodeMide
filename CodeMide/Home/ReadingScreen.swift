import SwiftUI

struct ReadingScreen: View {
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
    @StateObject private var viewModel = BPViewModel()
    @StateObject private var streammodel = EEGViewModel()
    @Binding var selectedtab : Int
    @State private var takebp = false
    @State private var showerror = false
    let sessionid: Int
    let questionid : Int
    @State private var recordingstart = false
    @State private var showalert = false
    @State private var alertmessage = ""
    @State private var bpalert = false
    var body: some View {
        ZStack{
            teal.ignoresSafeArea()
            VStack {
                HStack{
                    Image("codemide")
                        .resizable()
                        .frame(width: 80, height: 80)
                }
                
                VStack(alignment: .leading){
                    Text("Take Base Line Reading")
                        .foregroundStyle(Color.white)
                        .fontWeight(.semibold)
                        .font(.title2)
                    
                    Image("cuff")
                        .resizable()
                        .frame(width: 190,height: 190)
                }
                VStack(alignment: .leading){
                    
                    Text("Please Turn On RossMax Monitoring Device And Wear The Cuff Properly On Your Arm Before Taking the Reading.")
                        .foregroundStyle(teal)
                        .fontWeight(.semibold)
                    //                            .multilineTextAlignment(.center)
                    
                    
                    Button{
                        startbp()
                    }label: {
                        if takebp{
                            ProgressView()
                                .tint(.white)
                        }
                        else{
                            Text("Measure Blood Pressure")
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                        }
                    }
                    .frame(maxWidth: 200)
                    .padding()
                    .background(teal)
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity)
                    .disabled(takebp)
                    
                    
                }
                .padding(15)
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(12)
                .padding(.horizontal,20)
                //                .padding(.bottom,5)
                
                VStack(alignment:.leading){
                    Text("Your Blood Pressure Reading:")
                        .foregroundStyle(teal)
                        .fontWeight(.semibold)
                    
                    Text("Systolic: \(viewModel.baselineBP?.SYS ?? 0) mmHg")
                        .foregroundStyle(teal)
                    
                    Text("Diastolic: \(viewModel.baselineBP?.DIA ?? 0) mmHg")
                        .foregroundStyle(teal)
                    
                    Text("Pulse: \(viewModel.baselineBP?.PULSE ?? 0) bpm")
                        .foregroundStyle(teal)
                    
                }
                .padding(20)
                .frame(maxWidth: .infinity,alignment: .leading)
                .background(.white)
                .cornerRadius(12)
                .padding(.horizontal,20)
                
                
                //                NavigationLink(destination: AnswerScreen(question: "", duration: 0),
                //                               label: {
                //                    Text("Next")
                //                })
                //                .frame(maxWidth: 100)
                //                .padding()
                //                .background(.white)
                //                .foregroundStyle(teal)
                //                .cornerRadius(14)
                
                Button{
                    //                        streammodel.startrecording(sessionID: "sessionid", questionID: "questionid")
                    startreading()
                    //                        selectedtab += 1
                }label: {
                    if recordingstart{
                        ProgressView()
                            .tint(teal)
                    }else {
                        Text("Next")
                    }
                    
                }
                .frame(maxWidth: 100)
                .padding()
                .background(.white)
                .foregroundStyle(teal)
                .cornerRadius(14)
                .disabled(recordingstart)
                //                    .disabled(viewModel.bpData == nil)
                //                    .opacity(viewModel.bpData == nil ? 0.5 : 1)
                
                
                
                
                
                
                Spacer()
            }
            
            
        }
        .alert("Connection Error!",isPresented: $showalert){
            Button("OK",role: .cancel){
            }
        }message:{
            Text(alertmessage)
        }
        .alert("BP Error!",isPresented: $bpalert){
            Button("OK",role: .cancel){
            }
        }message:{
            Text(alertmessage)
        }
        
        .onChange(of: streammodel.isRecording){recording in
            if recording{
                recordingstart = false
                selectedtab += 1
            }
        }
        .onChange(of: streammodel.errorMessage){error in
            if let error = error {
                recordingstart = false
                alertmessage = error
                showalert = true
            }
        }
//        .onChange(of: viewModel.baselineBP){baselinebp in
//            if baselinebp{
//                takebp = false
//            }
//        }
        .onChange(of: viewModel.errorMessage){error in
            if let error = error{
                takebp = false
                alertmessage = error
                bpalert = true
            }
        }
        
    }
    func startbp(){
        takebp = true
        viewModel.measurebaselinebp()
//        streamModel.startstream(sessionID: sessionID, name: studentName )
        
    }
    func startreading(){
        recordingstart = true
        streammodel.startrecording(sessionID: "sessionid", questionID: "questionid")
    }
}

#Preview {
    ReadingScreen(selectedtab: .constant(0),sessionid: 0, questionid: 0)
}
