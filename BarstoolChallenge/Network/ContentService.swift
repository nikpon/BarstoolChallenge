import Foundation
import Alamofire

class ContentService {
    
    static let shared = ContentService()
    
    private init() {}
    
    // MARK:- Methods
    func getContent(for storyId: String, completion: @escaping(Result<NSAttributedString, AFError>) -> Void) {
        let url = "https://union.barstoolsports.com/v2/stories/" + storyId
        AF.request(url).validate().responseDecodable(of: Content.self) { response in
            if let content = response.value {
                let contentHTMLStr = content.text.convertToHTMLAttrStr()
                completion(.success(contentHTMLStr))
            } else if let error = response.error {
                completion(.failure(error))
            }
        }
    }
    
}

