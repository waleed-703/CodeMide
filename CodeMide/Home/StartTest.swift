import SwiftUI

struct StartTest: View {
    @StateObject private var viewModel = QuestionViewModel()
    @StateObject private var streamModel = EEGViewModel()
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
    @Binding var selectedtab : Int
    @State private var sessionID : String = UUID().uuidString
    let studentName : String
    let studentId : Int
    @State private var isloading = false
    @State private var showalert = false
    @State private var alertmessage = ""
    @State  var report = false
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
                
                ScrollView(){
                    VStack(alignment: .leading){
                        
                        Text("Question Statement:")
                            .foregroundStyle(teal)
                            .fontWeight(.semibold)
                        //                    Text(viewModel.selectedQuestion?.description ?? "")
//                        Text(viewModel.easyQuestion.description)
//                            .padding(.bottom,1)
                                                
                        VStack(alignment: .leading){
                            Text("Question: 1")
                                .fontWeight(.bold)
                            Text(viewModel.easyQuestion.description)
                        }
                        
                        VStack(alignment: .leading){
                            Text("Question: 2")
                                .fontWeight(.bold)
                            Text(viewModel.mediumQuestion.description)
                        }
                        
                        VStack(alignment: .leading){
                            Text("Question: 3")
                                .fontWeight(.bold)
                            Text(viewModel.hardQuestion.description)
                        }
                        
                        
                        
                        
                        
                        
                        
                        
                        
//                        Text("Question 2, Question 3 remaining")
//                            .fontWeight(.semibold)
//                            .padding(.bottom,1)
                        
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
                            streamconnection()
                            //                        selectedtab += 1
                        }label: {
                            if isloading{
                                ProgressView()
                                    .tint(.white)
                            }
                            else{
                                Text("StartTest")
                                    .foregroundStyle(.white)
                            }
                        }
                        .frame(maxWidth: 120)
                        .padding()
                        .background(teal)
                        .cornerRadius(12)
                        .frame(maxWidth: .infinity)
                        .disabled(isloading)
                        
//                        Button{
//                            report = true
//                        }label: {
////                            if isloading{
////                                ProgressView()
////                                    .tint(.white)
////                            }
////                            else{
////                                Text("See Report")
////                                    .foregroundStyle(.white)
////                            }
//                            Text("See Report")
//                                .foregroundStyle(.white)
//                        }
//                        .frame(maxWidth: 120)
//                        .padding()
//                        .background(teal)
//                        .cornerRadius(12)
//                        .frame(maxWidth: .infinity)
//                        .disabled(isloading)
                        
                        
                    }
                }
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(.white)
                .cornerRadius(10)
                .padding(.horizontal,15)
//                .padding(.vertical,60)
                
                .onAppear(){
                    viewModel.geteasyquestion(studentId: studentId)
                    viewModel.getmediumquestion(studentId: studentId)
                    viewModel.gethardquestion(studentId: studentId)
                }
                Spacer()
                
                
            }
//            .navigationDestination(isPresented: $report, destination: {ComparisonReport()})
        }
        .onChange(of: streamModel.isstreamconnected){connected in
            if connected{
                isloading = false
                selectedtab += 1
            }
        }
        
        .onChange(of: streamModel.errorMessage){error in
            if let error = error{
                isloading = false
                alertmessage = error
                showalert = true
            }
        }
        
        .alert("Connection Error!",isPresented: $showalert){
            Button("OK",role: .cancel){
            }
        }message:{
            Text(alertmessage)
        }
    }
    
//        .navigationDestination(
//            isPresented: $report,
//            destination: {ComparisonReport()
//            }
//        )
            
//    func streamconnection(){
//        isloading = true
//
//        streamModel.startstream(sessionID: sessionID, name: studentName )
//
//    }
    
//    func streamconnection(){
//
//        isloading = true
//
//        streamModel.isstreamconnected = false
//
//        streamModel.errorMessage = nil
//
//        streamModel.startstream(
//            sessionID: sessionID,
//            name: studentName
//        )
//    }
    func streamconnection() {

        isloading = true

        streamModel.errorMessage = nil

        EEGManager.startmuse(
            sessionID: sessionID,
            name: studentName
        ) { result in

            DispatchQueue.main.async {

                isloading = false

                switch result {

                case .success(let response):

                    print(
                        "STREAM SUCCESS:",
                        response.status
                    )

                    let status =
                    response.status.lowercased()

                    if status.contains("started") ||
                        status.contains("already") {

                        // ✅ MOVE TO NEXT SCREEN DIRECTLY
                        selectedtab += 1

                    } else {

                        alertmessage =
                        "Failed To Connect Device"

                        showalert = true
                    }

                case .failure(let error):

                    print(
                        "STREAM ERROR:",
                        error.localizedDescription
                    )

                    alertmessage =
                    error.localizedDescription

                    showalert = true
                }
            }
        }
    }
}

#Preview {
    StartTest(selectedtab: .constant(0),studentName: "",studentId: 0)
}
