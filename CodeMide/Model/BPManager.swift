import Foundation

struct BPData : Decodable{
    let status : String
    let SYS : Int
    let DIA : Int
    let PULSE : Int
}

struct EndBP : Decodable {
    let status : String
    let SYS : Int
    let DIA : Int
    let PULSE : Int
    let DeltaSYS : Int
    let DeltaDIA : Int
    let DeltaPulse : Int
    let TimeTaken : Int
}

class BPManager{
    
    static func measurebaseline(completion: @escaping (Result<BPData,Error>)->Void){
        NetworkManager.shared.request(endpoint: "/api/devices/eeg/start_session_bp", method: "POST"){result in
            switch result{
            case .success(let data):
                do{
                    let decoded = try JSONDecoder().decode(BPData.self,from: data)
                    completion(.success(decoded))
                }catch{
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func measurepostbp(completion: @escaping (Result<(EndBP),Error>)->Void){
        NetworkManager.shared.request(endpoint: "/api/devices/eeg/after_question_bp", method: "POST"){result in
            switch result{
            case .success(let data):
                do{
                    let decoded = try JSONDecoder().decode(EndBP.self, from: data)
//                    print("success",data)
                    completion(.success(decoded))
                }catch{
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
//                print("error",error)
            }
        }
    }
}

