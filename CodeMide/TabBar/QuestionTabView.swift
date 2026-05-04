import SwiftUI

struct QuestionTabView: View {
    @State var selectedtab = 0
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
    @StateObject var viewModel = QuestionViewModel()
    let studentId : Int
    @State private var questioncount  = 0
    @Binding var openreport : Bool
    @State var sessionid : Int
    @State var questionid : Int
    @State var answer : String
    @State var chatgpt : Bool
    var body: some View {
        ZStack{
            teal.ignoresSafeArea()
            VStack{
                TabView(selection: $selectedtab){
                    Group{
                        let studentName = UserDefaults.standard.string(forKey: "studentName") ?? "Unknown"
                        StartTest(selectedtab: $selectedtab,studentName: studentName,studentId: studentId)
    //                        .scrollDisabled(true)
                            .tag(0)
                        ReadingScreen(selectedtab: $selectedtab,sessionid: sessionid, questionid: questionid)
//                            .scrollDisabled(true)
                            .tag(1)
                        QuizScreen(selectedtab: $selectedtab,question: viewModel.question,sessionid: $sessionid,questionid: $questionid)
//                            .scrollDisabled(true)
                            .tag(2)
                        AnswerScreen(selectedtab: $selectedtab,question: viewModel.question,answer: $answer,chatgpt:$chatgpt,sessionid: sessionid)
                            .tag(3)
                        EndReadingScreen(selectedtab: $selectedtab,questioncount: questioncount,openreport: $openreport,answer: $answer ,chatgpt: $chatgpt,sessionid: sessionid)
                            .tag(4)
                            .onAppear{
                                questioncount += 1
                                if questioncount == 1 {
                                    viewModel.getmediumquestion(studentId: studentId)
                                }else if questioncount == 2 {
                                    viewModel.gethardquestion(studentId: studentId)
                                }else{
                                    
                                }
                            }
                        
                    }
                    .simultaneousGesture(DragGesture())
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
            .onAppear{
                
                viewModel.geteasyquestion(studentId: studentId)
                
//                viewModel.getmediumquestion(studentId: studentId)
                    
                
            }
            
        }

    }
}

#Preview {
    QuestionTabView(studentId: 1000, openreport: .constant(false),sessionid: 0, questionid: 0,answer: "",chatgpt: false)
}
