import Foundation

struct ppg_session : Decodable{
    let sessionid : String
    let sid : String
    let time : [Double]
    let HR : [Double]
    let SDNN : [Double]
    let RMSSD : [Double]
    let pNN50 : [Double]
    let total_files : Int
}


struct ppg_question : Decodable{
    let sessionid : String
    let sid : String
    let qid : String
    let file : PPGFile
    let HR : [Double]
    let SDNN : [Double]
    let RMSSD : [Double]
    let pNN50 : [Double]
}

struct PPGFile : Codable{
    let path : String
    let rows : Int
}


class PPGManager {

    // 🔹 FETCH ALL PPG
    static func fetchAllPPG(sessionID: String, sid: String,
                           completion: @escaping (Result<ppg_session, Error>) -> Void) {
        NetworkManager.shared.request(endpoint: "/api/devices/eeg/allp?sessionid=\(sessionID)&sid=\(sid)", method: "GET") { result in
            switch result {
            case .success(let data):
                do {
                    let decoded = try JSONDecoder().decode(ppg_session.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // 🔹 FETCH SINGLE PPG
    static func fetchSinglePPG(sessionID: String, sid: String, qid: String,
                              completion: @escaping (Result<ppg_question, Error>) -> Void) {

        NetworkManager.shared.request(endpoint: "/api/devices/eeg/single?sessionid=\(sessionID)&sid=\(sid)&qid=\(qid)", method: "GET") { result in
            switch result {
            case .success(let data):
                do {
                    let decoded = try JSONDecoder().decode(ppg_question.self, from: data)
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
