import SwiftUI

struct MainContainerView: View {
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
    @State private var selectedTab : Tabs = .Home
    let studentId : Int
    @State var openreport = false
    @State var sessionid : Int
    var body: some View {
//        NavigationStack{
            VStack{
                
                ZStack{
                    switch selectedTab {
                    case .Home:
                        HomeScreen(studentId : studentId,sessionid: sessionid)
                    case .Quiz:
                        QuestionTabView(studentId : studentId,openreport : $openreport,sessionid: sessionid,questionid: 0,answer: "",chatgpt: false)
                            .navigationDestination(isPresented: $openreport, destination: {
                                SelfReport(studentid: studentId,sessionid: sessionid,selectedtab: .constant(0))
                        })
                    case .Report:
                        AllReportsScreen(studentId: studentId)
                    case .Profile:
                        StudentProfile()
//                        StartTest()
                    }
                }
                
                TabBar(selectedTab: $selectedTab)
                
                
            }
            .background(.teal.opacity(0.56))
            .ignoresSafeArea(.container, edges: .bottom)
            
            
            
//        }
        
    }
}

#Preview {
    MainContainerView(studentId: 0,sessionid: 0)
}
