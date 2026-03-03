import Foundation

struct Report: Identifiable, Decodable{
//    let reportId: Int
    let sessionId: Int
    let date: String
    let afterQuestionBP: String
    let heartRate: Int
    let sdnn: Double
    let stressLevel: String

    var id: Int { sessionId }
}

struct QAReport : Codable {
    let qid : Int
    let description : String
    let duration : Int
    let total_attempts : Int
    let avg_bp : String
    let avg_heart_rate : Double?
    let avg_sdnn : Double?
    let avg_rmssd : Double?
    let avg_si : Double?
    let most_common_stress_level : String?
    
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
        let endpoint = "/api/report/reportbyqid/\(questionId)"
        
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

}
