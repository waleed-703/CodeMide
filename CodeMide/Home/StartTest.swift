import SwiftUI

struct StartTest: View {
    @StateObject private var viewModel = QuestionViewModel()
    @StateObject private var streamModel = EEGViewModel()
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
    @Binding var selectedtab : Int
    @State private var sessionID : String = UUID().uuidString
    let studentName : String
    var body: some View {
        ZStack{
            teal.ignoresSafeArea()
            
            VStack{
                Image("codemide")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80,height: 80)
                
//                Spacer()
                
                VStack{
                    Text("Programming Test")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                    
                    Image("eegdevice")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 220, height: 220)
                }
                
                
                VStack(alignment: .leading){
                    
                        Text("Question Statement:")
                            .foregroundStyle(teal)
                            .fontWeight(.semibold)
                    Text(viewModel.selectedQuestion?.description ?? "")
                        .padding(.bottom,1)
                    
                    
                        
                        
                    
                    
                    Text("Question 2, Question 3 remaining")
                        .fontWeight(.semibold)
                        .padding(.bottom,1)
                    
                    Text("Your focus level, stress and heart rate signals will be recorded during the test for performance analysis.Please remain calm and avoid unnecessary movement.")
                        .padding(.bottom,1)
                        .foregroundStyle(.gray)
                        .font(.caption)
                    
                    Text("Please Turn On The Monitoring Device to capture Your EEG and PPG data before starting the test.")
                        .foregroundStyle(teal)
                        .fontWeight(.semibold)
                    
//                    NavigationLink(destination: ReadingScreen()
//                                   , label:{
//                        Text("Start Test")
//                            .foregroundStyle(.white)
//
//                    })
//                    .frame(maxWidth: 120)
//                    .padding()
//                    .background(teal)
//                    .cornerRadius(12)
//                    .frame(maxWidth: .infinity)
                    Button{
                        streamModel.startstream(sessionID: sessionID, name: studentName )
                        selectedtab += 1
                    }label: {
                        Text("StartTest")
                            .foregroundStyle(.white)
                    }
                    .frame(maxWidth: 120)
                    .padding()
                    .background(teal)
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity)
                    
                    
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(10)
                .padding(.horizontal,15)
//                .padding(.vertical,60)
                
                .onAppear(){
                    viewModel.loadbyid(id: 2000)
                }
                Spacer()
                
                
            }
        }
    }
}

#Preview {
    StartTest(selectedtab: .constant(0),studentName: "")
}
