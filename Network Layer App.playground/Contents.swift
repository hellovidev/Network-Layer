import UIKit

// MARK: - Base function where process request configuration
func request(path: String, complition: @escaping (Result<Data, Error>) -> Void) {
    // URL initialization
    let urlString = "domain.com" + path
    let url = URL(string: urlString)!
    let urlRequest = URLRequest(url: url)
    
    // URL configuration
    let config = URLSessionConfiguration.default
    config.allowsCellularAccess = true
    
    // Request creation
    let session = URLSession(configuration: config)
    let task = session.dataTask(with: urlRequest) { data, response, error in
        if let data = data {
            complition(.success(data))
        }
        complition(.failure(error!))
    }
    
    // Start request process
    task.resume()
}

// MARK: - Special cases of requests
func getUser() {
    request(path: "/user") { result in
        switch result {
        case .success(let data):
            print("User: \(data)")
        case .failure(let error):
            print("Load user failed: \(error.localizedDescription)")
        }
    }
}
