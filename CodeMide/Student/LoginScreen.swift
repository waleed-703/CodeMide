import SwiftUI

enum UserRole{
    case admin
    case student
}
struct LoginScreen: View {
    @State var regno = ""
    @State var password = ""
    @State var login = false
    @State var userRole : UserRole?
    @State var register = false
    @State var passvisible = true
    @State var studentname = ""
    @State var semester = ""
//    @State private var authenticateSid : Int = 0
    @State private var rememberme = false
    

    
    
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
    var body: some View {
            ZStack{
                teal.ignoresSafeArea()
                VStack{
                    Spacer()
                    VStack{
                        HStack{
                            Image("codemide")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 300, height: 300)
                        }
                        HStack{
                            Text("Login To Continue")
                                .foregroundStyle(Color.white)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                        
                    }
                    .padding(.top,6)
                    
                    Spacer()
                    
                    VStack(spacing:16){
                        
                        VStack(alignment: .leading, spacing: 8){
                            Text("UserName:")
                                .font(.subheadline)
                            
                            HStack{
                                
                                TextField("Enter Username",text: $regno)
                                    .frame(maxWidth: .infinity)
                                    .padding(12)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                    .autocapitalization(.none)
                            }
                        }
                        
                        
                        VStack(alignment: .leading){
                            Text("Password:")
                                .font(.subheadline)
                            HStack {
                                
                                if passvisible{
                                    SecureField("Enter Password",text: $password)
                                        .autocapitalization(.none)
                                    
                                }
                                else{
                                    TextField("Enter Password",text: $password)
                                        .autocapitalization(.none)
                                 
                                }
                                
                                
                                
                                Button(action: {passvisible.toggle()})
                                {
                                    Image(systemName: passvisible ? "eye.slash" : "eye")
                                        .foregroundStyle(teal)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .padding(12)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                            
                            HStack{
                                Toggle(isOn: $rememberme){
                                    Text("Remember Me")
                                }
                                
                            }
                        }
                        Button(action: {
                            LoginManager.login(username: regno, password: password){
                                result in DispatchQueue.main.async(){
                                    switch result{
                                        case.success(let responce):
//                                        self.authenticateSid = responce.sId ?? 0
                                        if responce.role == "admin"{
                                            userRole = .admin
                                        }else{
                                            userRole = .student
                                            
                                            UserDefaults.standard.set(responce.name ?? "",forKey: "studentName")
                                            UserDefaults.standard.set(responce.semester ?? "",forKey:"semesterNo")
                                            UserDefaults.standard.set(responce.regno ?? "",forKey:"regno")
//                                            UserDefaults.standard.set(responce.gender ?? "",forKey:"gender")
//                                            UserDefaults.standard.set(responce.password ?? "",forKey:"password")
//                                            UserDefaults.standard.set(responce.cgpa ?? "",forKey:"cgpa")
                                            
                                            UserDefaults.standard.set(responce.sId,forKey: "studentId")
                                            
                                            UserDefaults.standard.synchronize()
                                            

                                        }
                                        login = true
                                        if rememberme {
                                            UserDefaults.standard.set(regno, forKey: "savedUsername")
                                            UserDefaults.standard.set(password, forKey: "savedPassword")
                                            UserDefaults.standard.set(true, forKey: "rememberMe")
                                        } else {
                                            UserDefaults.standard.removeObject(forKey: "savedUsername")
                                            UserDefaults.standard.removeObject(forKey: "savedPassword")
                                            UserDefaults.standard.set(false, forKey: "rememberMe")
                                        }
                                        
                                    case.failure(let error):
                                        print("Login Failed",error.localizedDescription)
                                        
                                    }
                                }
                            }
                        }, label: {
                            Text("Login")
                        })
                            .frame(maxWidth: 150)
                            .padding()
                            .background(teal)
                            .foregroundColor(.white)
                            .cornerRadius(8)


                        Button(action :{
                            register = true
                        },label:{
                                HStack{
                                    Text("New Here?")
                                        .font(.subheadline)
                                        .foregroundStyle(Color.black)
                                }
                                HStack{
                                    Text("Register Now")
                                        .font(.subheadline)
                                        .foregroundStyle(teal)
                                }
                                 
                            })

                    }
                    .padding(20)
                    .frame(maxWidth: .infinity,alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.horizontal,25)
                    
                    
                    
                    Spacer()
                }
                .onAppear {
                    let isRemembered = UserDefaults.standard.bool(forKey: "rememberMe")
                    
                    if isRemembered {
                        regno = UserDefaults.standard.string(forKey: "savedUsername") ?? ""
                        password = UserDefaults.standard.string(forKey: "savedPassword") ?? ""
                        rememberme = true
                    }
                }
                
            }
 
            .navigationDestination(isPresented: $login){
                switch userRole {
                case .admin:
                    AdminScreen(studentId: UserDefaults.standard.integer(forKey: "studentId"))
                case .student:
                    MainContainerView(studentId: UserDefaults.standard.integer(forKey: "studentId"))
//                    MainContainerView(studentId: authenticateSid)
                case nil:
                    LoginScreen()
                }
            }
        
            .navigationDestination(isPresented: $register,
                                   destination: {RegisterScreen()})
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack{
        LoginScreen()
    }
}
