import Foundation

struct StartStream : Decodable {
    let status : String
    let error : String?
}

struct RecordingResponce : Decodable {
    let status : String
    let error : String?
}

struct SelfResponce : Decodable{
    let status : String
    let sessionid : Int?
    let error : String?
}

struct SelfResponceReport : Encodable{
    let mental : Int
    let effort : Int
    let frustration : Int
    let comments : String
}

class EEGManager{
    
    static func startmuse(sessionID: String, name: String , completion : @escaping(Result<StartStream, Error>)->Void){
        let body: [String: Any] = [
            "session_id" : sessionID,
            "name" : name
        ]
        NetworkManager.shared.request(endpoint: "/api/devices/start_stream", method: "POST"){result in
            switch result{
            case .success(let data):
                do{
                    let decoded = try JSONDecoder().decode(StartStream.self, from: data)
                    completion(.success(decoded))
                }catch{
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    static func stopmuse(completion: @escaping(Result<StartStream,Error>)->Void){
        NetworkManager.shared.request(endpoint: "/api/devices/stop_stream", method: "POST"){result in
            switch result{
            case .success(let data):
                do{
                    let decoded = try JSONDecoder().decode(StartStream.self, from: data)
                    completion(.success(decoded))
                }catch{
                    completion(.failure(error))
                }
            case(.failure(let error)):
                completion(.failure(error))
            }
        }
    }
    
    static func startrecording(sessionID:String, questionID: String,completion: @escaping(Result<RecordingResponce,Error>)->Void){
        let body: [String: Any] = [
            "sid": sessionID,
            "qid": questionID
        ]
        NetworkManager.shared.request(endpoint: "/api/devices/start_recording", method: "POST"){result in
            switch result{
            case .success(let data):
                do{
                    let decoded = try JSONDecoder().decode(RecordingResponce.self, from: data)
                    completion(.success(decoded))
                }catch{
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func stoprecording(answers:String, gptIndex: Int,completion: @escaping(Result<RecordingResponce,Error>)->Void){
        let body: [String: Any] = [
            "answers" : answers,
            "gptindex" : gptIndex
        ]
        NetworkManager.shared.request(endpoint: "/api/devices/stop_recording", method: "POST"){result in
            switch result{
            case .success(let data):
                do{
                    let decoded = try JSONDecoder().decode(RecordingResponce.self, from: data)
                    completion(.success(decoded))
                }catch{
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func selfresponcereport(mental: Int, effort: Int, frustration: Int,comments: String, completion: @escaping(Result<SelfResponce,Error>)->Void){
        let body = SelfResponceReport(mental: mental, effort: effort, frustration: frustration, comments: comments)
        NetworkManager.shared.request(endpoint: "/api/devices/selfreport", method: "POST"){result in
            switch result{
            case .success(let data):
                do{
                    let decoded = try JSONDecoder().decode(SelfResponce.self, from: data)
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
