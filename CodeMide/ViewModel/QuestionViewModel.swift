import Foundation

class QuestionViewModel: ObservableObject{
    @Published var questions : [Question] = []
    @Published var selectedQuestion : Question?
    @Published var isLoading = false
    @Published var errorMessage : String?
    @Published var question: Question = .init(qid: 0, description: "", duration: 0, questionlevel: "", count: 0)
//    @Published var mediumquestion: MediumQuestion?
//    @Published var hardquestion: HardQuestion?
    
    func fetchQuestion(){
        QuestionManager.fetchAllQuestions{result in
            DispatchQueue.main.async{
                switch result{
                case .success(let questions):
                    self.questions = questions
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func loadbyid(id: Int){
        QuestionManager.fetchquestion(questionId: id){result in
            DispatchQueue.main.async{
                switch result{
                case .success(let question):
                    self.selectedQuestion = question
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
            
        }
    }
    
    func updateQuestion(id: Int, description: String, duration: Int,questionlevel: String,completion: @escaping ()->Void){
        let updatedquestion = Question(
            qid : id,
            description: description,
            duration: duration,
            questionlevel: questionlevel,
            count: 0
            
        )

        QuestionManager.updatequestion(id: id, question: updatedquestion){result in
            
            DispatchQueue.main.async{
                switch result{
                case .success:
                    
                    self.fetchQuestion()
//                    completion()
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func deletequestion(id:Int){
        QuestionManager.deleteQuestion(id: id){result in
            DispatchQueue.main.async{
                switch result{
                case .success:
                    self.questions.removeAll { $0.qid == id }
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
            
        }
        
    }
    
    func addquestion(description: String,duration:Int,questionlevel: String,completion: @escaping () -> Void){
        QuestionManager.addquestion(description: description, duration: duration, questionlevel: questionlevel){result in
            DispatchQueue.main.async{
                switch result{
                case .success:
                    self.fetchQuestion()
                    completion()
                case .failure(let error):
                    print(error.localizedDescription)
                }
                
            }
            
        }
    }
    
    func geteasyquestion(studentId : Int){
        QuestionManager.geteasyquestion(studentId: studentId){result in
            DispatchQueue.main.async{
                switch result{
                case .success(let fetchedQuestion):
                    self.question = fetchedQuestion
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getmediumquestion(studentId : Int){
        QuestionManager.getmediumquestion(studentId: studentId){result in
            DispatchQueue.main.async{
                switch result{
                case .success(let fetchedQuestion):
                    self.question = fetchedQuestion
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func gethardquestion(studentId : Int){
        QuestionManager.gethardquestion(studentId: studentId){result in
            DispatchQueue.main.async{
                switch result{
                case .success(let fetchedQuestion):
                    self.question = fetchedQuestion
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
