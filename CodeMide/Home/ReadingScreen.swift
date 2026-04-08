import SwiftUI

struct ReadingScreen: View {
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
    @StateObject private var viewModel = BPViewModel()
    @StateObject private var streammodel = EEGViewModel()
    @Binding var selectedtab : Int
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
                        viewModel.measurebaselinebp()
                    }label: {
                        Text("Measure Blood Pressure")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: 200)
                    .padding()
                    .background(teal)
                    .cornerRadius(12)
                    .frame(maxWidth: .infinity)
                    
                    
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
//                        streammodel.startrecording()
                        selectedtab += 1
                    }label: {
                        Text("Next")
                    }
                    .frame(maxWidth: 100)
                    .padding()
                    .background(.white)
                    .foregroundStyle(teal)
                    .cornerRadius(14)
//                    .disabled(viewModel.bpData == nil)
//                    .opacity(viewModel.bpData == nil ? 0.5 : 1)
                
                
                


                
                Spacer()
            }
            
            
        }
        
    }
}

#Preview {
    ReadingScreen(selectedtab: .constant(0))
}
