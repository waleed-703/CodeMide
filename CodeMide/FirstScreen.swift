import SwiftUI

struct FirstScreen: View {
//    let onContinue: () -> Void
    @State private var login = false
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
    var body: some View {
        NavigationStack{
            ZStack{
                teal.ignoresSafeArea()
                VStack{
                    Spacer()
                    VStack{
//                        Spacer()
                        Image("codemide")
                            .resizable()
                            .imageScale(.large)
                            .font(.largeTitle)
                            .foregroundStyle(Color.white)
                            .frame(width: 350, height: 350)
//                            .background(Color.brown)
//                            .cornerRadius(500)
//                            .padding()
                        //                    Text("Code Mide")
                        //                        .font(.largeTitle)
                        //                        .fontWeight(.semibold)
                        //                        .foregroundStyle(Color.white)
                    }
//                    Spacer()
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("Measure, Monitor")
                                .foregroundStyle(Color.white)
                                .fontWeight(.semibold)
                        }
                        HStack{
                            Text("Stress.")
                                .foregroundStyle(Color.white)
                                .fontWeight(.semibold)
                        }
                    }
//                    .padding()
                        Spacer()
                        
//                        NavigationLink(destination: LoginScreen(),
//                                       label:{
//                            Text("Continue")
//                        })
//                        .frame(maxWidth: 120)
//                        .padding()
//                        .background(Color.white)
//                        .foregroundStyle(teal)
//                        .cornerRadius(8)
                        .navigationDestination(isPresented: $login){
                            LoginScreen()
                        }
                    
//                    Button{
//                        onContinue()
//                    }label: {
//                        Text("Continue")
//                    }
//                    .frame(maxWidth: 120)
//                    .padding()
//                    .background(Color.white)
//                    .foregroundStyle(teal)
//                    .cornerRadius(8)
                    
                        
                    Spacer()
                    
                }
                .onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                        login = true
                    }
                }
            }
        }
    }
}

#Preview {
    FirstScreen()
}
