
import Foundation

enum Environment {
    enum Constants {
        static let baseURL = "https://api.themoviedb.org/3/movie/"
        static let apiKey = "e7277de5cbdf6c55a28dad303cd91351"
        static let popular = "popular?"
        static let favorite = "top_rated"
    }
    
    case popular
    case favorite
    
    func getURLString() -> String {
        switch self {
        case .popular: return Constants.baseURL + Constants.popular
        case .favorite: return Constants.baseURL + Constants.favorite
        }
    }
}

final class APIManager {
    private let urlSession = URLSession.shared
    private let jsonDecoder = JSONDecoder()
    
    func getMovie(for environment: Environment, completion: @escaping (Result<Movies, Error>) -> Void) {
        let urlString = environment.getURLString()
        guard let urlComponents = URLComponents(string: urlString) else { return }
        var components = urlComponents
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Environment.Constants.apiKey)
        ]
        
        guard let completeURL = components.url else { return }
        
        let task = urlSession.dataTask(with: completeURL) {[weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                completion(.failure(error))
            }
            
            if let data = data {
                if let decodedData = try? self.jsonDecoder.decode(Movies.self, from: data) {
                    completion(.success(decodedData))
                }
            }
        }
        task.resume()
    }
}
