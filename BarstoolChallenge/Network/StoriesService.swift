import Alamofire

class StoriesService {
    
    static let shared = StoriesService()
    
    private init() {}
    
    // MARK:- Methods
    func getStories(for stringUrl: String, with parameters: [String: String], completion: @escaping(Result<[Story], AFError>) -> Void) {
        AF.request(stringUrl, parameters: parameters).validate().responseDecodable(of: [Story].self) { response in
            if let stories = response.value {
                completion(.success(stories))
            } else if let error = response.error {
                completion(.failure(error))
            }
        }
    }
    
}
