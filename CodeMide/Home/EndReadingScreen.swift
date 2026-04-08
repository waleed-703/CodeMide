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
    var body: some View {
        ZStack{
            teal.ignoresSafeArea()
            VStack{
                VStack{
                    Image("codemide")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100,height: 100)
                    
                }
                
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
                        viewModel.measureendbp()
                    }label: {
                        Text("Measure Blood Pressure")
                            .foregroundStyle(.white)
                    }
                    .frame(width: 200)
                    .padding()
                    .background(teal)
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity)
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
                            streammodel.stoprecording(answers: answer, gptIndex: chatgpt ? 1 : 0)
                            streammodel.stopstream()
                            openreport.toggle()
                        }label: {
                            Text("End")
                                .foregroundStyle(.white)
                        }
                        .frame(width: 120)
                        .padding()
                        .background(teal)
                        .cornerRadius(12)
                        .frame(maxWidth: .infinity)
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
                        streammodel.stoprecording(answers: answer, gptIndex: chatgpt ? 1 : 0)
                        answer = ""
                        chatgpt = false
                        selectedtab = 1
                    }label: {
                        Text("Next - Question")
                            .foregroundStyle(teal)
                            .fontWeight(.semibold)
                    }
                    .frame(width:150)
                    .padding()
                    .background(.white)
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity)
//                    .disabled(viewModel.endBP == nil)
//                    .opacity(viewModel.endBP == nil ? 0.5 : 1)
                }

                
                Spacer()
               
            }
            
            
            
            
            
            
        }
    }
}

#Preview {
    EndReadingScreen(selectedtab: .constant(0), questioncount: 3,openreport: .constant(false),answer: .constant(""),chatgpt: .constant(false))
}
