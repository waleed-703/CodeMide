import Foundation

struct StudentList: Identifiable, Codable {
    let sid: Int
    let regno: String
    let name: String
    let semester: Int

    var id: Int { sid }

    enum CodingKeys: String, CodingKey {
        case sid, regno, name, semester
    }
}

struct Student: Identifiable, Decodable, Encodable,Equatable {
    let sid: Int
    var regno: String
    var name: String
    var gender: String
    var password: String
    var cgpa: Double
    var semester: Int

    var id: Int { sid }
    
    init(sid: Int, regno: String,name: String, gender: String, password: String, cgpa: Double, semester : Int ){
        
        self.sid = sid
        self.regno = regno
        self.name = name
        self.gender = gender
        self.password = password
        self.cgpa = cgpa
        self.semester = semester
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sid = try container.decode(Int.self, forKey: .sid)
        self.regno = try container.decode(String.self, forKey: .regno)
        self.name = try container.decode(String.self, forKey: .name)
        self.gender = try container.decode(String.self, forKey: .gender)
        self.password = try container.decode(String.self, forKey: .password)
        self.cgpa = Double( try container.decode(String.self, forKey: .cgpa)) ?? 0
        self.semester = try container.decode(Int.self, forKey: .semester)
    }
}
struct UpdateResponce : Decodable{
    let message : String
}



//struct Session : Codable{
//    let session_id : Int
//    let date : String?
//    let final_stress_level : String?
//}
class StudentManager{
    static func fetchall(completion: @escaping (Result<[StudentList],Error>)->Void){
        NetworkManager.shared.request(endpoint: "/api/student/getall", method: "GET")
        {
            result in
            switch result{
            case .success(let data):
                do{
                    let decoded = try JSONDecoder().decode([StudentList].self,from: data)
                    completion(.success(decoded))
                } catch{
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
                
            }
        }
    }
    
    static func getbyid(id: Int, completion: @escaping (Result<Student,Error>)->Void){
        NetworkManager.shared.request(endpoint: "/api/student/getbyid/\(id)", method: "GET"){
            result in
            switch result{
            case .success(let data):
                do{
                    let decoded = try JSONDecoder().decode(Student.self, from: data)
                    completion(.success(decoded))
                }catch{
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func updatestudent(id: Int, student: Student, completion: @escaping (Result<UpdateResponce,Error>)->Void){
        let body: [String:Any] = [
            "regno": student.regno,
            "name": student.name,
            "gender": student.gender,
            "cgpa": student.cgpa,
            "semester": student.semester,
            "password": student.password
        ]
        NetworkManager.shared.request(endpoint: "/api/student/update/\(id)", method: "PUT",body: body){
            result in
            switch result{
            case .success(let data):
                do{
                    let decoded = try JSONDecoder().decode(UpdateResponce.self, from: data)
                    completion(.success(decoded))
                }catch{
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func deleteStudent(id: Int,completion: @escaping(Result<String,Error>)->Void){
        NetworkManager.shared.request(endpoint: "/api/student/delete/\(id)", method: "DELETE"){result in
            switch result{
            case .success:
                completion(.success("Student Deleted Successfully!"))
            case .failure(let error):
                completion(.failure(error))
            }
            
        }
    }
    

    
}


    


                                              
