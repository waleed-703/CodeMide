import Foundation

class ReportViewModel : ObservableObject{
    @Published var reports : [Report] = []
    @Published var report : QAReport?
    @Published var errorMessage : String?
    @Published var sessionlist : [Report] = []
    @Published var sessionReport : SReport?
    @Published var squestionReport : SQReport?
    @Published var selfReport: selfreport?
    
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
                    print("report",report)
                    self.report = report
                case .failure(let error):
                    print("error",error)
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func loadallsession(for sid: Int){
        ReportManager.getallreports(studentId: sid){result in
            DispatchQueue.main.async{
                switch result{
                case .success(let reports):
                    self.sessionlist = reports
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func getstudentreport(sid: Int,sessionid : Int){
        ReportManager.getstudentreport(sessionid: sessionid, sid: sid){result in
            DispatchQueue.main.async{
                switch result{
                case .success(let report):
                    self.sessionReport = report
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func getqstudentreport(sid :Int , qid : Int){
        ReportManager.fetchsquestion(qid: qid, sid: sid){result in
            DispatchQueue.main.async{
                switch result{
                case .success(let sqreport):
                    self.squestionReport = sqreport
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func getselfreport(sessionid : Int){
        ReportManager.SelfReport(sessionid: sessionid){result in
            DispatchQueue.main.async{
                switch result{
                case.success(let data):
                    self.selfReport = data
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
