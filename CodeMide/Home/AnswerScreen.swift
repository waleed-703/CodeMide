import SwiftUI

struct AnswerScreen: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = QuestionViewModel()
    @StateObject private var streammodel = EEGViewModel()
    @StateObject private var bpviewmodel = BPViewModel()
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
    @Binding var selectedtab : Int
    let question : Question
    @Binding var answer : String
//    @State private var question = ""
    @Binding var chatgpt : Bool
//    let question : String
//    let duration : Int
    @State private var stoprecording = false
    @State private var showalert = false
    @State private var alertmessage = ""
    @State private var showmidbpalert = false
    let sessionid: Int
    let questioncount : Int
    @State private var isMidBploading = false
    @State private var timeremaining : Int = 0
    @State private var timer : Timer?
    
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
                        .frame(width:100, height: 100)
                    Spacer()
                }
                .padding(.horizontal)
                
                VStack(alignment:.leading){
                    
                    ScrollView{
                        
                        VStack(alignment: .leading){
                            Text("Question Statement:")
//                                .font(.title2)
//                                .foregroundStyle(Color.white)
//                                .fontWeight(.semibold)
                            Text(question.description)
                                .foregroundStyle(.white)
                            HStack{
                                Image(systemName: "clock")
                                    .font(.title2)
//                                    .foregroundStyle(teal)
//                                Text("\(question.duration) min")
                                Text(formatTime(timeremaining))
                                    .font(.title2)
//                                    .foregroundStyle(teal)
                            }
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background(Color.white.opacity(0.6))
                            .clipShape(Capsule())
                            .frame(maxWidth: .infinity)
                        }
//                        .padding(.vertical,30)
//                        .padding(.horizontal,100)
                        .padding(20)
                        .frame(maxWidth: .infinity,alignment: .leading)
//                        .padding(30)
//                        .frame(maxWidth: .infinity)
                        .background(teal)
                        .cornerRadius(12)
                        

                        
                        
//                        VStack(alignment: .leading,spacing: 12){
//                            Text("Question Statement:")
//                                .foregroundStyle(teal)
////                            Text("Instructions:")
////                                .foregroundStyle(teal)
//                            Text(question.description)
//                            
//                        }
                        
//                        .frame(maxWidth: .infinity,alignment: .leading)
//                        .padding(30)
//                        .padding(.horizontal,20)
//                        .padding(.vertical,50)
                        
//                        .background(Color.white)
//                        .cornerRadius(12)
                        
                        .onAppear(){
//                            viewModel.loadbyid(id: 2000)
                            timeremaining = question.duration * 60
                            startTimer()
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 300){
                                showmidbpalert = true
                            }

                        }
//                                        padding()
                        VStack(alignment: .leading){
                           
                            
                                HStack {
                                    Text("Answer:")
                                        .foregroundStyle(teal)
                                        .font(.headline)
                                
                                Spacer()
                                
                                    Toggle(isOn: $chatgpt){
                                        Text("ChatGPT")
                                            .foregroundStyle(teal)
                                            .fontWeight(.semibold)
                                    }
                                    .fixedSize()
                                }
                                .padding(.horizontal,6)
                            
                            
                            VStack(){
                                TextEditor(text: $answer)
//                                    .font(.system(.body, design: .monospaced))
                                    .padding(10)
                                    .autocapitalization(.none)
                                    .frame(height:300)

                            }
//                            .padding(70)
                            .background(Color.white)
                            .cornerRadius(12)
                        }
                        
                        HStack{
//                            NavigationLink(destination: EndReadingScreen(),
//                                           label:{
//                                Text("Next")
//                            } )
//                            .frame(maxWidth: 150)
//                            .padding()
//                            .background(teal)
//                            .foregroundColor(.white)
//                            .cornerRadius(12)
                            Button{
//                                recordingstop()
//                                streammodel.stoprecording(answers: answer, gptIndex: chatgpt ? 1 : 0)
                                selectedtab += 1
                            }label:{
                                if stoprecording{
                                    ProgressView()
                                        .tint(.white)
                                }else {
                                    Text("Next")
                                }
                                
                            }
                            .frame(maxWidth: 150)
                            .padding()
                            .background(teal)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            .disabled(stoprecording)
                        }
                        .padding(20)
                        
                        Text("Auto sumbits when time ends")
                            .font(.caption)
                            .foregroundStyle(Color.gray)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))
                    .cornerRadius(20)
                    .padding(.horizontal, 12)
                    
                }
                
                
            }
        }
        
        .alert("Connection Error!",isPresented: $showalert){
            Button("OK",role: .cancel){
            }
        }message:{
            Text(alertmessage)
        }
        
        .onChange(of: streammodel.isRecording){ recording in
            if !recording && stoprecording {
                stoprecording = false
                selectedtab += 1
                
            }
        }
        .onChange(of: streammodel.errorMessage){error in
            if let error = error{
                stoprecording = false
                alertmessage = error
                showalert = true
            }
        }
        .onChange(of: bpviewmodel.isMidBPLoading){loading in
            if loading == false {
                showmidbpalert = false
            }
        }
        .alert("Mid Question Blood Pressure",isPresented: $showmidbpalert){
            Button{
                bpviewmodel.midbp()}
            label:{
                if bpviewmodel.isMidBPLoading{
                    ProgressView()
                }else{
                    Text("Take Mid Bp")
                }
            }
            .disabled(bpviewmodel.isMidBPLoading)
            
            Button("Cancel",role: .cancel){}
            .foregroundStyle(.red)
        }message:{
                Text("Turn On The Device To Take Mid Question BP.")
            }
        
//        .toolbar{
//            ToolbarItem(placement : .topBarLeading){
//                Button(action : {
//                    dismiss()
//                }){
//                    HStack{
//                        Image(systemName : "chevron.left")
//                        Text("Back")
//                    }
//                }
//            }
//        }

        .navigationBarBackButtonHidden(true)
    }
    func recordingstop(){
        stoprecording = true
        streammodel.stoprecording(answers: answer, gptIndex: chatgpt ? 1 : 0)
    }
    
    func startTimer(){
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ _ in
            if timeremaining>0{
                timeremaining -= 1
            }else {
                timer?.invalidate()
                
                recordingstop()
                selectedtab += 1
            }
        }
    }
    
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

#Preview {
    AnswerScreen(selectedtab: .constant(0),question: .init(qid: 0, description: "", duration: 0, questionlevel: "", count: 0),answer: .constant(""), chatgpt: .constant(false),sessionid: 0,questioncount: 0)
}
