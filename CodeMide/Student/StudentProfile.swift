import SwiftUI

struct StudentProfile: View {
    @Environment(\.dismiss) var dismiss
    @State var studentname = ""
    @State var gender = ""
    @State var regno = ""
    @State var sem = ""
    @State var cgpa = ""
    @State var password = ""
    @State private var selectedopt = "Male"
    @State private var selection = 0
    @State var passvisible = true
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
    @StateObject private var viewModel = StudentViewModel()
    var body: some View {
            ZStack{
                teal.ignoresSafeArea()
                VStack{
                    HStack{
                        Image("codemide")
                            .resizable()
                            .frame(width:80, height: 80)
//                            .background(Color.black)
                    }
                    Spacer()
                    ScrollView(){
                        
                        VStack(){
                            
                            //                                        Spacer()
                            VStack(){
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .frame(width: 95,height: 95)
                                    .foregroundStyle(teal)
                                Text(studentname)
                                    .font(.largeTitle)
                                    .foregroundStyle(teal)
                            }
                            Spacer()
                            
                            VStack(spacing : 5){
                                VStack(alignment: .leading){
                                    Text("Student Name:")
                                        .font(.subheadline)
                                        .foregroundStyle(Color.white)
                                    HStack{
                                        TextField("Enter Your Name:",text: $studentname)
//                                            .frame(maxWidth: .infinity)
                                            .padding(12)
                                            .background(Color(.systemGray6))
                                            .cornerRadius(8)
                                    }
                                }
                                
                                VStack(alignment: .leading){
                                    
                                    Text("Gender:")
                                        .font(.subheadline)
                                        .foregroundStyle(Color.white)
                                    Picker("Gender", selection: $selectedopt){
                                        Text("Male").tag("Male")
                                        Text("Female").tag("Female")
                                    }
                                    .pickerStyle(.segmented)
//                                    .frame(width: 320)
                                }
                                
                                VStack(alignment: .leading){
                                    Text("RegNo:")
                                        .font(.subheadline)
                                        .foregroundStyle(Color.white)
                                    HStack{
                                        TextField("Enter Your Regno:",text: $regno)
//                                            .frame(maxWidth: 300)
                                            .padding(12)
                                            .background(Color(.systemGray6))
                                            .cornerRadius(8)
                                    }
                                }
                                
                                VStack(alignment: .leading){
                                    Text("Semester:")
                                        .font(.subheadline)
                                        .foregroundStyle(Color.white)
                                    HStack{
                                        TextField("Enter Your Semester:",text: $sem)
//                                            .frame(maxWidth: 300)
                                            .padding(12)
                                            .background(Color(.systemGray6))
                                            .cornerRadius(8)
                                    }
                                }
                                
                                VStack(alignment: .leading){
                                    Text("CGPA:")
                                        .font(.subheadline)
                                        .foregroundStyle(Color.white)
                                    HStack{
                                        TextField("Enter Your Cgpa:",text: $cgpa)
//                                            .frame(maxWidth: 300)
                                            .padding(12)
                                            .background(Color(.systemGray6))
                                            .cornerRadius(8)
                                    }
                                }
                                
                                VStack(alignment: .leading){
                                    Text("Password:")
                                        .font(.subheadline)
                                        .foregroundStyle(Color.white)
                                    HStack{
                                        if passvisible{
                                            SecureField("Enter Your Password:",text: $password)
                                        }
                                        else{
                                            TextField("Enter Your Password:",text: $password)
                                        }
                                        
                                        Button(action: {passvisible.toggle()})
                                        {
                                            Image(systemName: passvisible ? "eye.slash" : "eye")
                                                .foregroundStyle(teal)
                                        }
                                    }
//                                    .frame(maxWidth: 300)
                                    .padding(12)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(8)
                                }
                                
                                HStack{
                                    Button{
                                        if let originalstudent = viewModel.selectedStudent{
                                            let cgpa: Double = Double(cgpa) ?? 0
                                            let updatedStudent = Student(sid: originalstudent.sid, regno: regno, name: studentname, gender: selectedopt, password: password, cgpa: Double(cgpa), semester: Int(sem) ?? 0)
                                            
                                            viewModel.updateStudent(updatedStudent: updatedStudent){
//                                                editstudent = false
                                                viewModel.selectedStudent = nil
                                            }
                                        }

                                    }label: {
                                        Text("Update")
                                            .foregroundStyle(Color(red: 0.36, green: 0.85, blue: 0.93))
                                    }
                                    .frame(maxWidth: 80)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(8)
                                    
                                    
                                    NavigationLink(destination: LoginScreen(),
                                                   label:{
                                        Text("Logout")
                                            .foregroundStyle(Color(red: 0.36, green: 0.85, blue: 0.93))
                                    })
                                    .frame(maxWidth: 80)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(8)
                                }
                            }
                            .padding(16)
                            .frame(maxWidth: .infinity)
                            .background(teal)
                            .cornerRadius(12)
                            .padding(.horizontal,16)
                            
                            
                        }
                        
                    }
                    
                    .padding(.top,12)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.horizontal,12)
//                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    Spacer()
                }
                .onAppear(){
                    viewModel.fetchstudentprofile()
                }
                .onChange(of: viewModel.selectedStudent) { student in
                            if let s = student {
                                self.studentname = s.name
                                self.regno = s.regno
                                self.sem = "\(s.semester)"
                                self.cgpa = "\(s.cgpa)"
                                self.selectedopt = s.gender
                                self.password = s.password
                            }
                        }
                
        }
    }
}

#Preview {
    StudentProfile()
}
