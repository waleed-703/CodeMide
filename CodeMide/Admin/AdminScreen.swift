enum TabType{
    case students
    case questions
}
import SwiftUI
struct AdminScreen: View {
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
    @State private var selectedTab: TabType = .students
    let studentId : Int
    var body: some View {
            ZStack(alignment: .top){
                teal.ignoresSafeArea()
                
                    .toolbar{
                        ToolbarItem(placement:.topBarTrailing){
                            NavigationLink(destination: LoginScreen(),
                                           label: {
                                Text("Logout")
                                    .foregroundStyle(.white)
                                    .fontWeight(.semibold)
                            })
                            .padding(.horizontal,3)
                        }
                    }
                    .navigationBarBackButtonHidden(true)
                
                VStack(){
                    HStack{
                        Image("codemide")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70,height: 70)
                    }
                    VStack(){
                        VStack(alignment: .leading,spacing: 4){
                            
                            VStack(alignment: . leading,spacing: 5){
                                HStack{
//                                    Text("Hello")
//                                        .font(.title)
//                                        .foregroundStyle(Color.white)
                                    Text("Welcome!")
                                        .font(.title)
                                        .foregroundStyle(Color.white)
                                        .fontWeight(.semibold)
                                    
                                }
                                VStack(alignment:.leading){
                                    Text("Admin Portal (Student &")
                                        .font(.title3)
                                        .foregroundStyle(Color.white)
                                    Text("Question Management)")
                                        .font(.title3)
                                        .foregroundStyle(.white.opacity(0.95))
                                }
                            }
                            .padding()
                            VStack{
                                HStack{
                                    Spacer()
                                    Button {
                                        selectedTab = .students
                                    } label: {
                                        Text("Students")
                                    }
                                    .fontWeight(.semibold)
                                    .frame(width: 160)
                                    .padding(.vertical,16)
                                    .foregroundStyle(selectedTab == .students ? Color.white: teal)
                                    .background(
                                        selectedTab == .students ? teal : Color.white
                                    )
                                    .clipShape(Capsule())
                                    Spacer()
                                    Button {
                                        selectedTab = .questions
                                    } label: {
                                        Text("Questions")
                                    }
                                    .fontWeight(.semibold)
                                    .frame(width: 160)
                                    .padding(.vertical, 16)
                                    .foregroundStyle(selectedTab == .questions ? Color.white : teal)
                                    .background(selectedTab == .questions ? teal : Color.white)
                                    .clipShape(Capsule())
                                    
                                    Spacer()
                                    
                                }
                                ScrollView{
                                    VStack{
                                        if selectedTab == .students{
                                            StudentPanel(studentId : studentId)
                                        }else{
                                            QuestionPanel()
                                        }
                                    }
                                }
                                .padding(20)
                                .frame(maxWidth: .infinity)
                                .background(.white)
                                .cornerRadius(20)
                                
                                
                                
                                
                                
                            }
                            .padding()
                            .background(.white.opacity(0.6))
                            .frame(maxWidth: .infinity)
                            .cornerRadius(30)
                            .padding(.horizontal,16)
                            
                            
                            
                        }
                    }
                }
            }
    }
}


#Preview {
    NavigationStack{
        AdminScreen(studentId: UserDefaults.standard.integer(forKey: "studentId"))
    }
}
