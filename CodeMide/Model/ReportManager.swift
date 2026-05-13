import Foundation

//struct Report: Identifiable, Decodable{
////    let reportId: Int
//    let sessionId: Int
//    let date: String
//    let afterQuestionBP: String
//    let heartRate: Double?
//    let sdnn: Double
//    let stressLevel: String
//
//    var id: Int { sessionId }
//}

struct Report: Identifiable, Decodable {

    let sessionId: Int

    let date: String?

    let afterQuestionBP: String?

    let heartRate: Double?

    let sdnn: Double?

    let stressLevel: String?

    var id: Int { sessionId }
}

struct QAReport : Codable {
    let qid : Int
    let description : String
    let duration : Int
    let total_attempts : Int
    let with_gpt : QAdminReport
    let without_gpt : QAdminReport
    
    
}

struct QAdminReport : Codable{
    let total_attempts : Int?
    let avg_bp : String?
    let avg_hr : String?
    let avg_sdnn : String?
    let avg_rmssd : String?
    let avg_si : String?
    let most_common_stress_level : String?
    
}

struct SReport : Codable  {
    let session_id : Int
    let student_name : String
    let date : String?
    let final_stress_level : String?
    let total_minutes : Int?
    let average_bpa : String?
    let average_bpb : String?
    let average_bpm : String?
    let HR : Double?
    let SDNN : Double?
    let RMSSD : Double?
    let pNN50 : Double?
    let SI : Double?
    let attempted_questions : [SQuestion]
}

struct SQuestion : Codable {
    let qid : Int
    let description : String
}

struct SQReport : Codable {
    let question_id : Int
    let description : String
    let time_taken : String
    let bpb : String?
    let bpa : String?
    let bpm : String?
    let HR : Double?
    let SDNN : Double?
    let RMSSD : Double?
    let SI : Double?
    let stress_level : String?
}

struct selfreport : Decodable{
    let MentalLoad: Int
    let Frustration: Int
    let Effort: Int
    let Comment: String
}

struct PredictionResponse: Codable {

    let message: String
    let processedQuestions: Int
    let totalQuestions: Int
    let results: [PredictionResult]

    enum CodingKeys: String, CodingKey {
        case message
        case processedQuestions = "processed_questions"
        case totalQuestions = "total_questions"
        case results
    }
}

struct PredictionResult: Codable, Identifiable {

    var id: Int { questionAttemptId }

    let questionAttemptId: Int
    let status: String
    let stressLabel: String?
    let stressScore: Double?
    let hrv: HRVData?
    let windowsProcessed: Int?
    let windowBreakdown: [WindowBreakdown]?

    enum CodingKeys: String, CodingKey {
        case questionAttemptId = "question_attempt_id"
        case status
        case stressLabel = "stress_label"
        case stressScore = "stress_score"
        case hrv
        case windowsProcessed = "windows_processed"
        case windowBreakdown = "window_breakdown"
    }
}

struct HRVData: Codable {

    let HR: Double
    let SDNN: Double
    let RMSSD: Double
    let pNN50: Double
    let SI: Double
}

struct WindowBreakdown: Codable, Identifiable {

    var id: Int { window }

    let window: Int
    let label: String
    let confidence: Double
}


class ReportManager{
    static func fetchtopreports(
        studentId: Int,
        completion: @escaping (Result<[Report], Error>) -> Void
    ) {
        let endpoint = "/api/report/sessiontop5/\(studentId)"

        NetworkManager.shared.request(
            endpoint: endpoint,
            method: "GET"
        ) { result in
            switch result {

            case .success(let data):
                do {
                    let decoded = try JSONDecoder().decode([Report].self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func getallreports(studentId: Int,completion: @escaping(Result<[Report], Error>) -> Void)
    {
        let endpoint = "/api/report/allsession/\(studentId)"
        
        NetworkManager.shared.request(endpoint: endpoint, method: "GET"){result in
            switch result{
            case .success(let data):
                do{
                    let decoded = try JSONDecoder().decode([Report].self,from: data)
                    completion(.success(decoded))
                }catch{
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
    static func getadminreport(questionId: Int,completion: @escaping(Result<QAReport, Error>) -> Void){
        let endpoint = "/api/report/qus_rep_admin/\(questionId)"
        
        NetworkManager.shared.request(endpoint: endpoint, method: "GET"){result in
            switch result{
            case .success(let data):
                do{
                    let decoded = try JSONDecoder().decode(QAReport.self, from: data)
                    completion(.success(decoded))
                }catch{
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func getstudentreport(sessionid: Int,sid : Int,completion: @escaping(Result<SReport,Error>)->Void){
        NetworkManager.shared.request(endpoint: "/api/report/student_session_report/\(sid)/\(sessionid)", method: "GET"){result in
            switch result{
            case .success(let data):
                do{
                    let decoded = try JSONDecoder().decode(SReport.self,from: data)
                    //                    print("success",data)
                    completion(.success(decoded))
                }catch{
                    print("error",error)
                    completion(.failure(error))
                }
            case .failure(let error):
                print("error",error)
                completion(.failure(error))
                
                
            }
        }
    }
    
    static func fetchsquestion(qid : Int,sid : Int , completion: @escaping(Result<SQReport,Error>)->Void){
        NetworkManager.shared.request(endpoint: "/api/report/student_question_report/\(sid)/\(qid)", method: "GET"){result in
            switch result{
            case .success(let data):
                do{
                    let decoded = try JSONDecoder().decode(SQReport.self, from: data)
                    completion(.success(decoded))
                }catch{
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func SelfReport(sessionid: Int,completion:@escaping(Result<selfreport,Error>)->Void){
        NetworkManager.shared.request(endpoint: "/api/report/selfreport/\(sessionid)", method: "GET"){result in
            switch result{
            case .success(let data):
                do{
                    let decoded = try JSONDecoder().decode(selfreport.self, from: data)
                    completion(.success(decoded))
                }catch{
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func predictSession(
        sessionId: Int,
        completion: @escaping(Result<PredictionResponse, Error>) -> Void
    ){

        let endpoint = "/api/devices/Model/predict_session/\(sessionId)"

        NetworkManager.shared.request(
            endpoint: endpoint,
            method: "GET"
        ){ result in

            switch result {

            case .success(let data):

                do {

                    let decoded = try JSONDecoder()
                        .decode(PredictionResponse.self, from: data)

                    completion(.success(decoded))

                } catch {

                    completion(.failure(error))
                }

            case .failure(let error):

                completion(.failure(error))
            }
        }
    }

}
