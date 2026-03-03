import Foundation

class ReportViewModel : ObservableObject{
    @Published var reports : [Report] = []
    @Published var report : QAReport?
    @Published var errorMessage : String?
    
    
    func getreports(studentId : Int){
//        let studentId = UserDefaults.standard.integer(forKey: "studentId")
        ReportManager.getallreports(studentId : studentId){result in
            DispatchQueue.main.async{
                switch result{
                case .success(let fetchReports):
                    self.reports = fetchReports
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
            
        }
    }
    
    func fetchadminreport(questionId :Int){
        ReportManager.getadminreport(questionId: questionId){result in
            DispatchQueue.main.async{
                switch result{
                case .success(let report):
                    self.report = report
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
