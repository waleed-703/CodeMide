import Foundation

struct Report: Identifiable, Decodable{
//    let reportId: Int
    let sessionId: Int
    let date: String
    let afterQuestionBP: String
    let heartRate: Double
    let sdnn: Double
    let stressLevel: String

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
    let average_bp : String?
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
    let bp : String?
    let HR : Double?
    let SDNN : Double?
    let RMSSD : Double?
    let SI : Double?
    let stress_level : String?
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

}
