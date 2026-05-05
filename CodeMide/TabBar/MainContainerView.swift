import SwiftUI

struct MainContainerView: View {
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
    @State private var selectedTab : Tabs = .Home
    let studentId : Int
    @State var openreport = false
    let sessionid : Int
    var body: some View {
//        NavigationStack{
            VStack{
                
                ZStack{
                    switch selectedTab {
                    case .Home:
                        HomeScreen(studentId : studentId)
                    case .Quiz:
                        QuestionTabView(studentId : 1000,openreport : $openreport,sessionid: 0,questionid: 0,answer: "",chatgpt: false)
                            .navigationDestination(isPresented: $openreport, destination: {
                                SelfReport(studentid: 0,sessionid: sessionid)
                        })                    case .Report:
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
