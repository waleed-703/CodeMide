import Foundation

struct Question : Decodable, Identifiable, Equatable{
    let qid : Int
    let description : String
    let duration : Int
    let questionlevel : String?
    let count : Int
    
    var id: Int{qid}
}

struct QUpdateResponce : Decodable{
    let message : String
}

class QuestionManager{
    static func fetchquestion(questionId: Int, completion : @escaping (Result<Question,Error>)-> Void){
        let endpoint = "/api/question/getbyid/\(questionId)"
        
        NetworkManager.shared.request(endpoint: endpoint, method: "GET"){
            result in
                switch result{
                case .success(let data):
                    do{
                        let decoded = try JSONDecoder().decode(Question.self, from: data)
                        completion(.success(decoded))
                    }catch{
                        completion(.failure(error))
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
        }
    }
    
    static func fetchAllQuestions(completion: @escaping(Result<[Question],Error>)->Void){
        let endpoint = "/api/question/getall"
        
        NetworkManager.shared.request(endpoint: endpoint, method: "GET"){result in
            switch result{
            case .success(let data):
                do{
                    let decoded = try JSONDecoder().decode([Question].self,from: data)
                    completion(.success(decoded))
                }catch{
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
    static func updatequestion(id: Int, question: Question, completion: @escaping (Result<QUpdateResponce,Error>)->Void){
        let body: [String:Any] = [
            "description": question.description,
            "duration": question.duration
        ]
        NetworkManager.shared.request(endpoint: "/api/question/update/\(id)", method: "PUT",body: body){
            result in
            switch result{
            case .success(let data):
                do{
                    let decoded = try JSONDecoder().decode(QUpdateResponce.self, from: data)
                    completion(.success(decoded))
                }catch{
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func deleteQuestion(id: Int,completion: @escaping(Result<String,Error>)->Void){
        NetworkManager.shared.request(endpoint: "/api/question/delete/\(id)", method: "DELETE"){result in
            switch result{
            case .success:
                completion(.success("Question Deleted Successfully!"))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    
    static func addquestion(description:String, duration: Int, questionlevel: String,
                            completion: @escaping(Result<Void, Error>)->Void){
        
        let body: [String: Any] = [
            "description": description,
            "duration" : duration,
            "questionlevel" :questionlevel
        ]
        
        NetworkManager.shared.request(endpoint: "/api/question/insert", method: "POST",body: body){
            result in
            switch result{
            case.success:
                completion(.success(()))
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
}
