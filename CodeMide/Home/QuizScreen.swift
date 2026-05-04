
import SwiftUI

struct QuizScreen: View {
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
    @StateObject private var viewModel = QuestionViewModel()
    @StateObject private var streammodel = EEGViewModel()
    @State var answer = false
//    @State var question = ""
//    @State var duration = 0
//    @State var errormessage = ""
    @State var showerror = false
    //    @State private var chatgpt = false
    @Binding var selectedtab : Int
    let question : Question
    @Binding var sessionid : Int
    @Binding var questionid : Int
    var body: some View {
        ZStack{
            teal.ignoresSafeArea()
            VStack{
                HStack{
//                    Spacer()
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
                        .frame(width:100, height: 90)
                    //                        .padding(.top)
                    
                    Spacer()
                    
                }
                .padding(.horizontal)
                
                VStack(){
                    Text("Programming Test")
                        .font(.title2)
                        .foregroundStyle(Color.white)
                    HStack{
                        Image(systemName: "clock")
                            .font(.title2)
//                                    .foregroundStyle(teal)
                        Text("\(question.duration) min")
                            .font(.title2)
//                                    .foregroundStyle(teal)
                        
                        
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(Color.white.opacity(0.6))
                    .clipShape(Capsule())


                    
                    VStack(alignment: .leading){
                        
                        Text("Question Statement:")
                            .foregroundStyle(teal)
                        
                        Text(question.description)
                        
                        
//                            .onAppear(){
//                                viewModel.loadbyid(id: 2001)
//
//                            }
                        
                        
                        Spacer()
                            .padding(.horizontal)
                        HStack{
//                            NavigationLink(destination: AnswerScreen(question: question, duration: duration),
//                                           label: {
//                                Text("Start Test")
//                            })
//                            .frame(maxWidth: 150)
//                            .padding()
//                            .background(teal)
//                            .foregroundColor(.white)
//                            .cornerRadius(12)
                            
                            Button{
                                streammodel.startrecording(sessionID: String(sessionid), questionID: String(questionid))
                                selectedtab += 1
                            }label:{
                                Text("Start Test")
                            }
                            .frame(maxWidth: 150)
                            .padding()
                            .background(teal)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                            
                        }
                        .padding(78)
                        .background(Color.white)
                    }
                    .padding(20)
                    .background(Color.white)
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal,12)
                    
                    Spacer()
                    
                    
                    Text("Complete Your Program Before The Timer Ends")
                        .font(.caption)
                }
                Spacer()
            }
            
        }

    }

}
#Preview {
    NavigationStack{
        QuizScreen(selectedtab : .constant(0),question : .init(qid: 0, description: "", duration: 0, questionlevel: "", count: 0),sessionid: .constant(0),questionid: .constant(0))
    }
}
