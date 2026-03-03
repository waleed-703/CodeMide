import SwiftUI

struct RegisterScreen: View {
    @Environment(\.dismiss) var dismiss
    @State var stname = ""
    @State var regno = ""
    @State var gender = ""
    @State var semester = ""
    @State var cgpa = ""
    @State var password = ""
    @State var cpassword = ""
    @State private var selectedopt = "Male"
    @State var passvisible = true
    @State var cpassvisible = true
    @State var register = false
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
    @State private var showalert = false
    @State private var passalert = false
    @State private var success = false
    var body: some View {
        

                
                    
                ZStack{
                    teal.ignoresSafeArea()

                    VStack{
                        Spacer()
                        VStack{
                            Image("codemide")
                                .resizable()
                                .frame(width: 150, height: 150)
                                .foregroundStyle(Color.white)
                                .font(.largeTitle)
                          
//                            Spacer()
                            Text("Please Create A New Account!")
                                .font(.subheadline)
                                .foregroundStyle(Color.white)
                                .fontWeight(.semibold)
//                                .padding()
                        }
                        
                        Spacer()
                        
                            VStack(spacing:15){
                                ScrollView{
                                VStack(alignment: .leading){
                                    Text("Student Name:")
                                        .font(.subheadline)
                                    
                                    HStack{
                                        
                                        TextField("Enter Your Name",text: $stname)
                                            .frame(maxWidth: 300)
                                            .padding(12)
                                            .background(Color(.systemGray6))
                                            .cornerRadius(8)
                                    }
                                }
                                
                                VStack(alignment: .leading){
                                    Text("RegNo:")
                                        .font(.subheadline)
                                    HStack {
                                        
                                        TextField("Enter RegNo:",text: $regno)
                                            .frame(maxWidth: 300)
                                            .padding(12)
                                            .background(Color(.systemGray6))
                                            .cornerRadius(8)
                                    }
                                }
                                
                                VStack(alignment: .leading){
                                    Text("Gender:")
                                        .font(.subheadline)
                                    Picker("Gender", selection: $selectedopt){
                                        Text("Male").tag("Male")
                                        Text("Female").tag("Female")
                                    }
                                    .pickerStyle(.segmented)
                                    .frame(width: 320)
                                }
                                
                                VStack(alignment: .leading){
                                    Text("Semester:")
                                        .font(.subheadline)
                                    HStack {
                                        
                                        TextField("Enter Semester:",text: $semester)
                                            .frame(maxWidth: 300)
                                            .padding(12)
                                            .background(Color(.systemGray6))
                                            .cornerRadius(8)
                                    }
                                }
                                
                                VStack(alignment: .leading){
                                    Text("Cgpa:")
                                        .font(.subheadline)
                                    HStack {
                                        
                                        TextField("Enter CGPA:",text: $cgpa)
                                            .frame(maxWidth: 300)
                                            .padding(12)
                                            .background(Color(.systemGray6))
                                            .cornerRadius(8)
                                    }
                                }
                                
                                VStack(alignment: .leading){
                                    Text("Password:")
                                        .font(.subheadline)
                                    HStack {
                                        if passvisible
                                        {
                                            SecureField("Enter Password:",text: $password)
                                        }
                                        else{
                                            TextField("Enter Password:",text: $password)
                                        }
                                        
                                        Button(action: {passvisible.toggle()})
                                        {
                                            Image(systemName: passvisible ? "eye.slash" : "eye")
                                                .foregroundStyle(teal)
                                        }
                                        
                                    }
                                    .frame(maxWidth: 300)
                                    .padding(12)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                }
                                
                                VStack(alignment: .leading){
                                    Text("Confirm Password:")
                                        .font(.subheadline)
                                    HStack {
                                        if cpassvisible{
                                            SecureField("Enter Password:",text: $cpassword)
                                        }
                                        else{
                                            TextField("Enter Password:",text: $cpassword)
                                        }
                                        
                                        Button(action: {cpassvisible.toggle()})
                                        {
                                            Image(systemName: cpassvisible ? "eye.slash" : "eye")
                                                .foregroundStyle(teal)
                                        }
                                    }
                                    .frame(maxWidth: 300)
                                    .padding(12)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                }
                                
                                Spacer()
                                
                                    Button(action:{
                                        registerstudent()
                                    },
                                               label:{
                                    Text("Register")
                                })
                                .frame(maxWidth: 150)
                                .padding()
                                .background(Color(red: 0.36, green: 0.85, blue: 0.93))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                
                                .alert("Error!",isPresented: $showalert){
                                    Button("OK",role: .cancel){}
                                }message:{
                                    Text("Fill All Fields")
                                }
                                .alert("Success!",isPresented: $success){
                                    Button("OK",role: .cancel){
                                        register = true
                                    }
                                }message:{
                                    Text("User Created Successfully.")
                                }
                                    
                                .alert("Error!",isPresented: $passalert){
                                    Button("OK",role:.cancel){}
                                }message:{
                                    Text("Password Does Not Match.")
                                }
                                
                                
                                Spacer()
                            }
                        }
                        .padding(20)
                        .background(Color.white)
                        .cornerRadius(12)
                        Spacer()
                    }
            }
                .navigationDestination(isPresented: $register,
                                       destination: {LoginScreen()})
    }
    
    func registerstudent(){
        if stname.isEmpty || regno.isEmpty || password.isEmpty || cpassword.isEmpty || semester.isEmpty || cgpa.isEmpty {
                showalert = true
                return
            }
        if password != cpassword {
                passalert = true
                return
            }
        RegisterManager.registerStudent(name: stname, regno: regno, gender: selectedopt, password: password, cgpa: cgpa, semester: semester){result in
            switch result{
            case .success(let responce):
                print(responce.message)
                success = true
            case .failure(let error):
                print("Registration Failed",error.localizedDescription)
            }
        }
    }
}

#Preview {
    RegisterScreen()
}
