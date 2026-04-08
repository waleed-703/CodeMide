import Foundation

struct LoginRequest : Codable{
    let users : String
    let passwords : String
}


struct LoginResponse: Decodable {
    let role: String
//    let message: String?
    let sId: Int?
    let regno: String?
    let name: String?
    let semester: Int?
//    let gender : String?
//    let password : String?
//    let cgpa : String?
}


class LoginManager {

    static func login(
        username: String,
        password: String,
        completion: @escaping (Result<LoginResponse, Error>) -> Void
    ) {
        let body = [
            "users": username,
            "passwords": password
        ]

        NetworkManager.shared.request(
            endpoint: "/api/admin",
            method: "POST",
            body: body
        ) { result in
            switch result {
            case .success(let data):
                do {
                    let decoded = try JSONDecoder().decode(LoginResponse.self, from: data)
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
