//import Foundation
//
//class ReportViewModel : ObservableObject{
//    @Published var reports : [Report] = []
//    @Published var report : QAReport?
//    @Published var errorMessage : String?
//    @Published var sessionlist : [Report] = []
//    @Published var sessionReport : SReport?
//    @Published var squestionReport : SQReport?
//    @Published var selfReport: selfreport?
//    @Published var predictionReport: PredictionResponse?
//    @Published var predictionResults: [PredictionResult] = []
//    @Published var filteredReports: [FilterQuestionReport] = []
//    @Published var filterMessage: String?
//    
//    func getreports(studentId : Int){
////        let studentId = UserDefaults.standard.integer(forKey: "studentId")
//        ReportManager.getallreports(studentId : studentId){result in
//            DispatchQueue.main.async{
//                switch result{
//                case .success(let fetchReports):
//                    self.reports = fetchReports
//                case .failure(let error):
//                    self.errorMessage = error.localizedDescription
//                }
//            }
//            
//        }
//    }
//    
//    func fetchadminreport(questionId :Int){
//        ReportManager.getadminreport(questionId: questionId){result in
//            DispatchQueue.main.async{
//                switch result{
//                case .success(let report):
//                    print("report",report)
//                    self.report = report
//                case .failure(let error):
//                    print("error",error)
//                    self.errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
//    
//    func loadallsession(for sid: Int){
//        ReportManager.getallreports(studentId: sid){result in
//            DispatchQueue.main.async{
//                switch result{
//                case .success(let reports):
//                    self.sessionlist = reports
//                case .failure(let error):
//                    self.errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
//    
//    func getstudentreport(sid: Int,sessionid : Int){
//        ReportManager.getstudentreport(sessionid: sessionid, sid: sid){result in
//            DispatchQueue.main.async{
//                switch result{
//                case .success(let report):
//                    self.sessionReport = report
//                case .failure(let error):
//                    self.errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
//    
//    func getqstudentreport(sid :Int , qid : Int){
//        ReportManager.fetchsquestion(qid: qid, sid: sid){result in
//            DispatchQueue.main.async{
//                switch result{
//                case .success(let sqreport):
//                    self.squestionReport = sqreport
//                case .failure(let error):
//                    self.errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
//    
//    func getselfreport(sessionid : Int){
//        ReportManager.SelfReport(sessionid: sessionid){result in
//            DispatchQueue.main.async{
//                switch result{
//                case.success(let data):
//                    self.selfReport = data
//                case .failure(let error):
//                    self.errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
//    
//    func predictSession(sessionId: Int){
//
//        ReportManager.predictSession(
//            sessionId: sessionId
//        ){ result in
//
//            DispatchQueue.main.async {
//
//                switch result {
//
//                case .success(let prediction):
//
//                    self.predictionReport = prediction
//                    self.predictionResults = prediction.results
//
//                case .failure(let error):
//
//                    self.errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
//    
//    func filterQuestionReports(
//        qid: Int,
//        gender: String? = nil,
//        minCGPA: Double? = nil,
//        maxCGPA: Double? = nil,
//        semester: String? = nil,
//        gptindex: Int? = nil
//    ){
//
//        ReportManager.filterQuestionReports(
//            qid: qid,
//            gender: gender,
//            minCGPA: minCGPA,
//            maxCGPA: maxCGPA,
//            semester: semester,
//            gptindex: gptindex
//        ){ result in
//
//            DispatchQueue.main.async {
//
//                switch result {
//
//                case .success(let reports):
//
//                    self.filteredReports = reports
//                    self.filterMessage = nil
//
//                case .failure(let error):
//
//                    self.errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
//}


import Foundation

class ReportViewModel : ObservableObject {

    @Published var reports: [Report] = []

    @Published var report: QAReport?

    @Published var errorMessage: String?

    @Published var sessionlist: [Report] = []

    @Published var sessionReport: SReport?

    @Published var squestionReport: SQReport?

    @Published var selfReport: selfreport?

    @Published var predictionReport: PredictionResponse?

    @Published var predictionResults: [PredictionResult] = []

    @Published var filteredReports: [FilterQuestionReport] = []

    @Published var filterMessage: String?

    // MARK: LOADING

    @Published var isLoading: Bool = false

    // MARK: GET REPORTS

    func getreports(studentId: Int) {

        ReportManager.getallreports(studentId: studentId) { result in

            DispatchQueue.main.async {

                switch result {

                case .success(let fetchReports):

                    self.reports = fetchReports

                case .failure(let error):

                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    // MARK: ADMIN REPORT

    func fetchadminreport(questionId: Int) {

        ReportManager.getadminreport(questionId: questionId) { result in

            DispatchQueue.main.async {

                switch result {

                case .success(let report):

                    print("report", report)

                    self.report = report

                case .failure(let error):

                    print("error", error)

                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    // MARK: ALL SESSION

    func loadallsession(for sid: Int) {

        ReportManager.getallreports(studentId: sid) { result in

            DispatchQueue.main.async {

                switch result {

                case .success(let reports):

                    self.sessionlist = reports

                case .failure(let error):

                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    // MARK: STUDENT REPORT

    func getstudentreport(sid: Int, sessionid: Int) {

        ReportManager.getstudentreport(
            sessionid: sessionid,
            sid: sid
        ) { result in

            DispatchQueue.main.async {

                switch result {

                case .success(let report):

                    self.sessionReport = report

                case .failure(let error):

                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    // MARK: QUESTION STUDENT REPORT

    func getqstudentreport(sid: Int, qid: Int) {

        ReportManager.fetchsquestion(
            qid: qid,
            sid: sid
        ) { result in

            DispatchQueue.main.async {

                switch result {

                case .success(let sqreport):

                    self.squestionReport = sqreport

                case .failure(let error):

                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    // MARK: SELF REPORT

    func getselfreport(sessionid: Int) {

        ReportManager.SelfReport(sessionid: sessionid) { result in

            DispatchQueue.main.async {

                switch result {

                case .success(let data):

                    self.selfReport = data

                case .failure(let error):

                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    // MARK: PREDICTION

    func predictSession(sessionId: Int) {

        ReportManager.predictSession(
            sessionId: sessionId
        ) { result in

            DispatchQueue.main.async {

                switch result {

                case .success(let prediction):

                    self.predictionReport = prediction

                    self.predictionResults = prediction.results

                case .failure(let error):

                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    // MARK: FILTER QUESTION REPORTS

    func filterQuestionReports(
        qid: Int,
        gender: String? = nil,
        minCGPA: Double? = nil,
        maxCGPA: Double? = nil,
        semester: String? = nil,
        gptindex: Int? = nil
    ) {

        // START LOADING

        self.isLoading = true

        ReportManager.filterQuestionReports(
            qid: qid,
            gender: gender,
            minCGPA: minCGPA,
            maxCGPA: maxCGPA,
            semester: semester,
            gptindex: gptindex
        ) { result in

            DispatchQueue.main.async {

                // STOP LOADING

                self.isLoading = false

                switch result {

                case .success(let reports):

                    print("FILTERED REPORTS:", reports)

                    self.filteredReports = reports

                    self.filterMessage = nil

                case .failure(let error):

                    print("FILTER ERROR:", error.localizedDescription)

                    self.filteredReports = []

                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
