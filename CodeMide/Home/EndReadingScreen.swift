import SwiftUI

struct EndReadingScreen: View {
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
    @StateObject private var viewModel = BPViewModel()
    @StateObject private var streammodel = EEGViewModel()
    @Binding var selectedtab : Int
    let questioncount : Int
    @Binding var openreport : Bool
    @Binding var answer : String
    @Binding var chatgpt : Bool
    @State private var takeendbp = false
    @State private var bpalert = false
    @State private var alertmessage = ""
    @State private var showalert = false
    @State private var recordingstop = false
    let sessionid : Int
//    @State private var
    var body: some View {
        ZStack{
            teal.ignoresSafeArea()
            VStack{
                HStack{
                    Button(action: {
                        streammodel.ResetAll()
                        streammodel.deleteSession(sessionID: sessionid)
                        selectedtab = max(0, selectedtab - 1)
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.white)
                    }

                    Spacer()
                    
                    Image("codemide")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100,height: 100)
                    Spacer()
                }
                .padding(.horizontal)
                
                Spacer()
                
                Text("Take End Reading - Question")
                    .foregroundStyle(.white)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Image("cuff")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200,height: 200)
//                    .frame(maxHeight: .infinity)
                
                VStack(alignment: .leading){
                    Text("Please Turn on RossMax Monitoring device and wear the cuff propely on your arm before taking the reading.")
                        .foregroundStyle(.teal)
                        .fontWeight(.semibold)
                    
                    Button{
//                        viewModel.measureendbp()
                        endbp()
                    }label: {
                        if takeendbp{
                            ProgressView()
                                .tint(.white)
                        }
                        else{
                            Text("Measure Blood Pressure")
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                        }
//                        Text("Measure Blood Pressure")
//                            .foregroundStyle(.white)
                    }
                    .frame(width: 200)
                    .padding()
                    .background(teal)
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity)
                    .disabled(takeendbp)
                }
                .padding(15)
//                .padding(.vertical,20)
                .background(.white)
                .cornerRadius(12)
                .padding(.horizontal,20)
                
                
                
                VStack(alignment:.leading){
                    Text("Your Blood Pressure Reading:")
                        .foregroundStyle(teal)
                        .fontWeight(.semibold)
                    
                    Text("Systolic: \(viewModel.endBP?.SYS ?? 0) mmHg")
                        .foregroundStyle(teal)
                    
                    Text("Diastolic: \(viewModel.endBP?.DIA ?? 0) mmHg")
                        .foregroundStyle(teal)
                    
                    Text("Pulse: \(viewModel.endBP?.PULSE ?? 0) bpm")
                        .foregroundStyle(teal)
                    
                }
                .padding(20)
                .frame(maxWidth: .infinity,alignment: .leading)
                .background(.white)
                .cornerRadius(12)
                .padding(.horizontal,20)
                
                
//                NavigationLink(destination: AnswerScreen(question: "", duration: 0)
//                    , label: {
//                    Text("Next - Question")
//                        .foregroundStyle(teal)
//                        .fontWeight(.semibold)
//                })
//                .frame(width:150)
//                .padding()
//                .background(.white)
//                .cornerRadius(12)
//                .frame(maxWidth: .infinity)
                if questioncount == 3{
                    VStack(alignment: .leading,spacing: 15){
                        Text("Please Turn On The Monitoring Device To Capture Your EEG and PPG.")
                            .foregroundStyle(teal)
                            .fontWeight(.semibold)
   
                        Button{
//                            stopqrecording()
//                            streammodel.stoprecording(answers: answer, gptIndex: chatgpt ? 1 : 0)
                            streammodel.stopstream()
                            openreport.toggle()
                        }label: {
                            if recordingstop{
                                ProgressView()
                                    .tint(.white)
                            }else {
                                Text("End")
                                    .foregroundStyle(.white)
                            }

                        }
                        .frame(width: 120)
                        .padding()
                        .background(teal)
                        .cornerRadius(12)
                        .frame(maxWidth: .infinity)
                        .disabled(recordingstop)
//                        .disabled(viewModel.endBP == nil)
//                        .opacity(viewModel.endBP == nil ? 0.5 : 1)
                    }
                    .padding(10)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .background(.white)
                    .cornerRadius(12)
                    .padding(.horizontal,19)
                    
                }else{
                    Button{
//                        stopqrecording()
//                        streammodel.stoprecording(answers: answer, gptIndex: chatgpt ? 1 : 0)
                        answer = ""
                        chatgpt = false
                        selectedtab = 2
                    }label: {
                        if recordingstop {
                            ProgressView()
                                .tint(.white)
                        }else {
                            Text("Next - Question")
                                .foregroundStyle(teal)
                                .fontWeight(.semibold)
                        }
                    }
                    .frame(width:150)
                    .padding()
                    .background(.white)
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity)
//                    .disabled(viewModel.endBP == nil)
//                    .opacity(viewModel.endBP == nil ? 0.5 : 1)
                    .disabled(recordingstop)
                }

                
                Spacer()
               
            }
            
            
            
            
            
            
        }
        .onAppear {

            // Clear old BP values when screen opens again
            viewModel.endBP = nil

            // Reset loading states
            takeendbp = false
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
        
//        .onChange(of: streammodel.isRecording){recording in
//            if recording{
//                recordingstop = false
//                selectedtab = 2
//            }
//        }
        .onChange(of: streammodel.errorMessage){error in
            if let error = error {
                recordingstop = false
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
                takeendbp = false
                alertmessage = error
                bpalert = true
            }
        }
        
        .onChange(of: viewModel.endBP) { newBP in

            // BP reading completed successfully
            if newBP != nil {

                takeendbp = false
            }
        }
    }
    func endbp(){

        // reset old result
        viewModel.endBP = nil

        takeendbp = true

        viewModel.measureendbp()
    }
    func stopqrecording(){
        recordingstop = true
        streammodel.stoprecording(answers: answer, gptIndex: chatgpt ? 1 : 0)
        answer = ""
        chatgpt = false
    }
    func endrecording(){
        recordingstop = true
        streammodel.stoprecording(answers: answer, gptIndex: chatgpt ? 1 : 0)
        streammodel.stopstream()
        openreport.toggle()
    }
}

#Preview {
    EndReadingScreen(selectedtab: .constant(0), questioncount: 3,openreport: .constant(false),answer: .constant(""),chatgpt: .constant(false),sessionid: 0)
}
