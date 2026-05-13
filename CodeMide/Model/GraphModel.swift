import Foundation

struct EEGgraph : Decodable{
    let sessionid : String
    let sid : String
    let total_files : Int
    let files : [EEGFileInfo]
    let combined_total_rows : Int
    let time : [Double]
    let delta : [Double]
    let theta : [Double]
    let alpha : [Double]
    let beta : [Double]
    let gamma : [Double]
//    let bandtype : String
}

struct ThetaGraph : Decodable {
    let band : String
    let sessionid : String
    let sid : String
    let qid : String
    let file : EEGSingleFileInfo
    let time : [Double]
    let theta : [Double]
}

struct AlphaGraph : Decodable {
    let band : String
    let sessionid : String
    let sid : String
    let qid : String
    let file : EEGSingleFileInfo
    let time : [Double]
    let alpha : [Double]
}

struct BetaGraph : Decodable {
    let band : String
    let sessionid : String
    let sid : String
    let qid : String
    let file : EEGSingleFileInfo
    let time : [Double]
    let beta : [Double]
}

struct DeltaGraph : Decodable {
    let band : String
    let sessionid : String
    let sid : String
    let qid : String
    let file : EEGSingleFileInfo
    let time : [Double]
    let delta : [Double]
}

struct GammaGraph : Decodable {
    let band : String
    let sessionid : String
    let sid : String
    let qid : String
    let file : EEGSingleFileInfo
    let time : [Double]
    let gamma : [Double]
}

struct EEGFileInfo : Decodable , Identifiable {
    let id = UUID()
    let filename : String?
    let rows : Int?
    let duration : Double?
    
}

struct EEGSingleFileInfo : Decodable {
    let path : String?
    let rows : Int?
    
}

struct EEGgraphpoint : Identifiable{
    let id = UUID()
    let x : Double
    let y: Double
    let bandtype : String
}

struct CombinedQuestionGraph : Decodable {

    let sessionid : String
    let sid : String
    let total_questions : Int
    let questions : [CombinedQuestion]
}

struct CombinedQuestion : Decodable, Identifiable {

    let id = UUID()

    let qid : Int
    let bp : [QuestionBP]
    let eeg : QuestionEEG
}

struct QuestionBP : Decodable, Identifiable {

    let id = UUID()

    let type : String
    let minute : Double
    let SYS : Double
    let DIA : Double
}

struct QuestionEEG : Decodable {

    let time : [Double]
    let delta : [Double]
    let theta : [Double]
    let alpha : [Double]
    let beta : [Double]
    let gamma : [Double]
}

struct CombinedQuestionPoint : Identifiable {

    let id = UUID()

    let x : Double
    let y : Double
    let bandtype : String
}

class GraphModel{
    
    static func fetchgraphdata(sessionid : String, sid : String,completion: @escaping(Result<EEGgraph,Error>)->Void){
        NetworkManager.shared.request(endpoint: "/api/devices/eeg/all?sessionid=\(sessionid)&sid=\(sid)", method: "GET"){result in
            switch result{
            case .success(let data):
                do{
                    let decoded = try JSONDecoder().decode(EEGgraph.self, from: data)
                    completion(.success(decoded))
                }catch{
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func fetchThetadata(sessionid: String, sid: String, qid:String, completion: @escaping(Result<ThetaGraph,Error>)->Void){
        NetworkManager.shared.request(endpoint: "/api/devices/eeg/theta?sessionid=\(sessionid)&sid=\(sid)&qid=\(qid)", method: "GET"){result in
            switch result{
            case .success(let data):
                do{
                    let decoded = try JSONDecoder().decode(ThetaGraph.self, from: data)
                    completion(.success(decoded))
                }catch{
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func fetchalphaadata(sessionid: String, sid: String, qid:String, completion: @escaping(Result<AlphaGraph,Error>)->Void){
        NetworkManager.shared.request(endpoint: "/api/devices/eeg/alpha?sessionid=\(sessionid)&sid=\(sid)&qid=\(qid)", method: "GET"){result in
            switch result{
            case .success(let data):
                do{
                    let decoded = try JSONDecoder().decode(AlphaGraph.self, from: data)
                    completion(.success(decoded))
                }catch{
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func fetchbetadata(sessionid: String, sid: String, qid:String, completion: @escaping(Result<BetaGraph,Error>)->Void){
        NetworkManager.shared.request(endpoint: "/api/devices/eeg/beta?sessionid=\(sessionid)&sid=\(sid)&qid=\(qid)", method: "GET"){result in
            switch result{
            case .success(let data):
                do{
                    let decoded = try JSONDecoder().decode(BetaGraph.self, from: data)
                    completion(.success(decoded))
                }catch{
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func fetchdeltadata(sessionid: String, sid: String, qid:String, completion: @escaping(Result<DeltaGraph,Error>)->Void){
        NetworkManager.shared.request(endpoint: "/api/devices/eeg/delta?sessionid=\(sessionid)&sid=\(sid)&qid=\(qid)", method: "GET"){result in
            switch result{
            case .success(let data):
                do{
                    let decoded = try JSONDecoder().decode(DeltaGraph.self, from: data)
                    completion(.success(decoded))
                }catch{
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func fetchgammadata(sessionid: String, sid: String, qid:String, completion: @escaping(Result<GammaGraph,Error>)->Void){
        NetworkManager.shared.request(endpoint: "/api/devices/eeg/gamma?sessionid=\(sessionid)&sid=\(sid)&qid=\(qid)", method: "GET"){result in
            switch result{
            case .success(let data):
                do{
                    let decoded = try JSONDecoder().decode(GammaGraph.self, from: data)
                    completion(.success(decoded))
                }catch{
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func fetchCombinedQuestionData(
        sessionid : String,
        sid : String,
        completion: @escaping(Result<CombinedQuestionGraph,Error>)->Void
    ){
        
        NetworkManager.shared.request(
            endpoint: "/api/devices/eeg/combined-question-report?sessionid=\(sessionid)&sid=\(sid)",
            method: "GET"
        ){ result in
            
            switch result{
                
            case .success(let data):
                
                do{
                    
                    let decoded = try JSONDecoder().decode(
                        CombinedQuestionGraph.self,
                        from: data
                    )
                    
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
