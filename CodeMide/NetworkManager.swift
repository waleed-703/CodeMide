import Foundation

class NetworkManager: ObservableObject{
    
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = "http://192.168.1.11:5000"
//    private let baseURL = "http://127.0.0.1:5000"
//    private let baseURL = "http://172.16.14.84:5000"
    
    func request(
        endpoint: String,
        method: String,
        body: [String: Any]? = nil,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        guard let url = URL(string: baseURL + endpoint) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 400)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }

        URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(NSError(domain: "No Data", code: 500)))
                    return
                }

                completion(.success(data))
            }
        }.resume()
    }

}
