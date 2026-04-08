import SwiftUI
struct StudentPanel: View {
    private let teal = Color(red: 0.36, green: 0.85, blue: 0.93)
//    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = StudentViewModel()
    @StateObject private var reportModel = ReportViewModel()
    @State private var editstudent = false
    @State private var addstudent = false
    @State private var selectedStudentId : Int?
    @State private var selectedStudent: Student? = nil
    @State private var stname = ""
    @State private var gender = ""
    @State private var regno = ""
    @State private var semester = ""
    @State private var cgpa = ""
    @State private var password = ""
    @State private var cpassword = ""
    @State private var selectedopt = "Male"
    @State var passvisible = true
    @State var cpassvisible = true
    @State private var selection = 0
    @State var report = false
    @State private var showalert = false
    @State private var successalert = false
    @State private var passalert = false
    @State private var deletealert = false
    let studentId : Int
    var body: some View {
        ScrollView{
            VStack(spacing: 12){
                ForEach(viewModel.students){student in
                    HStack{
                        
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 50,height: 50)
                            .foregroundStyle(Color.white)
                        VStack(alignment: .leading){
                            Text(student.name)
                                .bold()
                                .foregroundStyle(Color.white)
                            Text(student.regno)
                                .font(.caption)
                                .foregroundStyle(Color.white)
                            Text("\(student.semester) Semester")
                                .font(.subheadline)
                                .foregroundStyle(Color.white)
                        }
                        Spacer()
                        VStack{
                            
                            HStack{
                                NavigationLink(destination: AllReportsScreen(studentId : student.sid),
                                               label: {
                                    Image(systemName: "doc.on.clipboard.fill")
                                        .font(.caption)
                                    Text("View Report")
                                        .font(.caption)
                                })
                                .padding(.horizontal,10)
                                .padding(.vertical, 10)
                                .foregroundStyle(teal)
                                .background(Color.white)
                                .clipShape(Capsule())
                                
                                
                            }
                            HStack{
                                Button{
                                    viewModel.loadbyid(id: student.sid)
                                    editstudent = true
                                    
                                }label: {
                                    Label("Edit", systemImage: "pencil")
                                        .font(.subheadline)
                                        .fontWeight(.semibold)
                                }
                                .padding(.horizontal,30)
                                .padding(.vertical,8)
                                .foregroundStyle(teal)
                                .background(Color.white)
                                .clipShape(Capsule())
                            }
                            
                            HStack{
                                Button{
                                    deletealert = true
                                    viewModel.deletestudent(id: student.sid)
                                }label: {
                                    Image(systemName: "trash")
                                    Text("Delete")
                                        .font(.caption)
                                        .fontWeight(.semibold)

                                }
                                .padding(.horizontal,22)
                                .padding(.vertical,8)
                                .foregroundStyle(.red)
                                .background(Color.white)
                                .clipShape(Capsule())
                            }
                            .alert("Delete!",isPresented: $deletealert){
                                Button("OK",role:.cancel){
                                     
                                }
                            }message:{
                                Text("Student Deleted Successfully.")
                            }
                        }
                    }
                    .padding(8)
                    .background(.teal.opacity(0.9))
                    .cornerRadius(16)
                    
                    
                    
                }
                //            .navigationBarBackButtonHidden(true)
            }

            
            .onAppear{
                viewModel.fetchStudents()
            }
            .onChange(of: selectedStudent) { student in
                        if let s = student {
                            self.stname = s.name
                            self.regno = s.regno
                            self.semester = "\(s.semester)"
                            self.cgpa = "\(s.cgpa)"
                            self.selectedopt = s.gender
                            self.password = s.password
                        }
                    }
            .onChange(of: viewModel.selectedStudent) { editstudent in
                        if let s = editstudent {
                            self.stname = s.name
                            self.regno = s.regno
                            self.semester = "\(s.semester)"
                            self.cgpa = "\(s.cgpa)"
                            self.selectedopt = s.gender
                            self.password = s.password
                            
                            self.editstudent = true
                        }
                    }
        }
        
        Button{
            stname = ""; regno = ""; gender = ""; semester = ""; cgpa = ""; password = ""; cpassword = ""
            addstudent = true
        }label: {
            Text("Add Student")
                .foregroundStyle(.teal)
        }
        .frame(maxWidth: 130)
        .padding()
        .background(.teal.opacity(0.3))
        .cornerRadius(10)
        
        
        .sheet(isPresented: $editstudent){
            VStack(alignment:.leading){
                HStack{
                    Text("Edit Student")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(teal)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
            }
            
            
            VStack(alignment:.leading){
                Section(){
                    Text("Student Name:")
                        .foregroundStyle(.white)
                    TextField("",text: $stname)
                        .frame(maxWidth: 300)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    Text("Gender:")
                        .foregroundStyle(.white)
                    Picker("Gender", selection: $selectedopt){
                        Text("Male").tag("Male")
                        Text("Female").tag("Female")
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 320)
                    
                    Text("RegNo:")
                        .foregroundStyle(.white)
                    TextField("",text : $regno)
                        .frame(maxWidth: 300)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    Text("Cgpa:")
                        .foregroundStyle(.white)
                    TextField("",text : $cgpa)
                        .frame(maxWidth: 300)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    Text("Semester:")
                        .foregroundStyle(.white)
                    TextField("",text : $semester)
                        .frame(maxWidth: 300)
                        .padding(12)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    
                    Text("Password:")
                        .foregroundStyle(.white)
                    HStack{
                        if passvisible{
                            SecureField("",text : $password)
                        }
                        else{
                            TextField("",text : $password)
                        }
                        
                        Button(action:{ passvisible.toggle()})
                        {
                            Image(systemName: passvisible ? "eye.slash" : "eye")
                                .foregroundStyle(teal)
                        }
                    }
                    .frame(maxWidth: 300)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    HStack{
                        Button{
                            if let originalstudent = viewModel.selectedStudent{
                                let cgpa: Double = Double(cgpa) ?? 0
                                let updatedStudent = Student(sid: originalstudent.sid, regno: regno, name: stname, gender: selectedopt, password: password, cgpa: Double(cgpa), semester: Int(semester) ?? 0)
                                
                                viewModel.updateStudent(updatedStudent: updatedStudent){
                                    editstudent = false
                                    viewModel.selectedStudent = nil
                                }
                            }
                        }label:{
                            Text("Save")
                                .foregroundStyle(teal)
                        }
                        .frame(maxWidth: 130)
                        .padding()
                        .background(.white)
                        .cornerRadius(12)
                        
                        Button{
                            editstudent = false
                        }label:{
                            Text("Back")
                                .foregroundStyle(teal)
                        }
                        .frame(maxWidth: 130)
                        .padding()
                        .background(.white)
                        .cornerRadius(12)
                    }
                }
            }
            .padding(.horizontal,26)
            .padding(.vertical,22)
            .background(teal)
            .cornerRadius(12)
            
            
//            .presentationDetents([.fraction(0.9)])
        }
        
       
        
        .sheet(isPresented: $addstudent){
            VStack(alignment:.leading){
                HStack{
                    Text("ADD Student")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(teal)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
            }
            
            VStack(alignment:.leading){
                Section(){
                    Text("Student Name:")
                        .foregroundStyle(.white)
                    TextField("",text : $stname)
                        .frame(maxWidth: 300)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    Text("Gender:")
                        .foregroundStyle(.white)
                    Picker("Gender", selection: $selectedopt){
                        Text("Male").tag("Male")
                        Text("Female").tag("Female")
                    }
                    .pickerStyle(.segmented)
                    .frame(width: 320)
                    
                    Text("RegNo:")
                        .foregroundStyle(.white)
                    TextField("",text : $regno)
                        .frame(maxWidth: 300)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    Text("Cgpa:")
                        .foregroundStyle(.white)
                    TextField("",text : $cgpa)
                        .frame(maxWidth: 300)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    Text("Semester:")
                        .foregroundStyle(.white)
                    TextField("",text : $semester)
                        .frame(maxWidth: 300)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                    
                    Text("Password:")
                        .foregroundStyle(.white)
                    HStack{
                        if passvisible{
                            SecureField("",text : $password)
                        }
                        else{
                            TextField("",text : $password)
                        }
                        
                        Button(action:{passvisible.toggle()})
                        {
                            Image(systemName: passvisible ? "eye.slash" : "eye")
                                .foregroundStyle(teal)
                        }
                    }
                    .frame(maxWidth: 300)
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    
                    Text("Confirm:")
                        .foregroundStyle(.white)
                    HStack{
                        if cpassvisible{
                            SecureField("",text : $cpassword)
                        }
                        else{
                            TextField("",text : $cpassword)
                        }
                        
                        Button(action: {cpassvisible.toggle()})
                        {
                            Image(systemName: cpassvisible ? "eye.slash" : "eye")
                                .foregroundStyle(teal)
                        }
                        
                    }
                    .frame(maxWidth: 300)
                    .padding(8)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                        

                    
                    
                    HStack{
//                        Spacer()
                        Button{
                            addnewstudent()
    //                            addstudent = false
                            
                        }label:{
                            Text("Save")
                                .foregroundStyle(teal)
                        }
                        .frame(maxWidth: 290)
                        .padding()
                        .background(.white)
                        .cornerRadius(12)
                        
//                        Spacer()
                        
//                        Button{
//
//
//                        }label:{
//                            Text("Delete")
//                                .foregroundStyle(.red)
//                        }
//                        .frame(maxWidth: 130)
//                        .padding()
//                        .background(.white)
//                        .cornerRadius(12)
                    }
                }
            }
            .padding(.horizontal,36)
            .padding(.vertical,22)
            .background(teal)
            .cornerRadius(8)
            
            .alert("Success!",isPresented: $successalert){
                Button("OK",role:.cancel){
                    addstudent = false
                }
            }message:{
                Text("Student Added Successfully.")
            }
            .alert("Error!",isPresented: $showalert){
                Button("OK",role: .cancel){}
            }message:{
                Text("Fill All Fields")
            }
            .alert("Error!",isPresented: $passalert){
                Button("OK",role:.cancel){}
            }message:{
                Text("Password Does Not Match.")
            }
            

        }
        
        
        .navigationDestination(isPresented: $report,
                               destination: {ReportScreen(sid: 1000,sessionid :3012)})
    }
    
    func addnewstudent(){
        if stname.isEmpty || regno.isEmpty || password.isEmpty || semester.isEmpty || cgpa.isEmpty {
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
                self.successalert = true
                viewModel.fetchStudents()
            case .failure(let error):
                print("Registration Failed",error.localizedDescription)
            }
        }
    }
        
    
        
}

#Preview {
    NavigationStack{
        StudentPanel(studentId: UserDefaults.standard.integer(forKey: "studentId"))
    }
}
