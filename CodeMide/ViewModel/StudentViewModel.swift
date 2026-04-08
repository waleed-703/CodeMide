import Foundation

class StudentViewModel: ObservableObject{
    @Published var students: [StudentList] = []
    @Published var selectedStudent : Student?
    @Published var isLoading = false
    @Published var errorMessage : String?
    
    
    func fetchStudents(){
        isLoading = true
        errorMessage = nil
        
        StudentManager.fetchall {result in
            DispatchQueue.main.async{
                self.isLoading = false
                
                switch result {
                case .success(let students):
                    self.students = students
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
            
        }
    }
    
    func loadbyid(id:Int){
        StudentManager.getbyid(id: id){result in
            DispatchQueue.main.async{
                switch result{
                case .success(let student):
                    self.selectedStudent = student
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
            
        }
    }
    
    func updateStudent(updatedStudent: Student,completion: @escaping ()->Void){
//        guard let student = selectedStudent
//        else{
//            return
//        }
        StudentManager.updatestudent(id: updatedStudent.sid, student: updatedStudent){result in
            DispatchQueue.main.async{
                switch result{
                case .success:
                    self.fetchStudents()
                    completion()
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func fetchstudentprofile(){
        let studentId = UserDefaults.standard.integer(forKey: "studentId")
        
        guard studentId != 0 else{
            errorMessage = "No Student Found"
            return
        }
        
        StudentManager.getbyid(id: studentId){result in
            DispatchQueue.main.async{
                switch result{
                case .success(let student):
                    self.selectedStudent = student
                    
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    
                    
                }
            }
            
        }
    }
    
    func deletestudent(id:Int){
        StudentManager.deleteStudent(id: id){result in
            DispatchQueue.main.async{
                switch result{
                case .success:
                    self.students.removeAll { $0.sid == id }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
            
        }
        
    }
    


}
