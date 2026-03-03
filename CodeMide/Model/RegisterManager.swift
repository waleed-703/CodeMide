import Foundation

struct RegisterResponse : Decodable{
    let message : String
}

class RegisterManager{
    
    static func registerStudent(name:String, regno: String, gender: String, password: String, cgpa: String,semester: String,
                                completion: @escaping(Result<RegisterResponse, Error>)->Void){
        
        let body: [String: Any] = [
            "regno": regno,
            "name" : name,
            "gender" : gender,
            "password" : password,
            "cgpa" : cgpa,
            "semester" : semester
        ]
        
        NetworkManager.shared.request(endpoint: "/api/student/insert", method: "POST",body: body){
            result in
            switch result{
            case.success(let data):
                do{
                    let decoded  = try JSONDecoder().decode(RegisterResponse.self,from: data)
                    completion(.success(decoded))
                }catch{
                    completion(.failure(error))
                }
                
            case.failure(let error):
                completion(.failure(error))
            }
        }
    }
}
