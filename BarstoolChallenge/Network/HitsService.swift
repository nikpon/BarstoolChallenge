import Alamofire

class HitsService {
    
    static let shared = HitsService()
    
    private init() {}
    
    // MARK:- Methods
    func getHits(for stringUrl: String, with parameters: [String: String], completion: @escaping(Result<[Hit], AFError>) -> Void) {
        AF.request(stringUrl, parameters: parameters).validate().responseDecodable(of: HitItems.self) { response in
            if let hitItems = response.value {
                completion(.success(hitItems.hits))
            } else if let error = response.error {
                print(error)
                completion(.failure(error))
            }
        }
    }
    
}
