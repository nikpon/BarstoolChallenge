import Foundation

struct Content: Codable {
    
    var text: String
    
    private enum RootCodingKeys: String, CodingKey {
        case text = "post_type_meta"
        
        enum NestedCodingKeys: String, CodingKey {
            case text = "standard_post"
            
            enum NestedCodingKeys: String, CodingKey {
                case text = "content"
            }
        }
    }
    
    init(from decoder: Decoder) throws {
        let rootContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let firstNestedContainer = try rootContainer.nestedContainer(keyedBy: RootCodingKeys.NestedCodingKeys.self, forKey: .text)
        let secondNestedContainer = try firstNestedContainer.nestedContainer(keyedBy: RootCodingKeys.NestedCodingKeys.NestedCodingKeys.self, forKey: .text)
        
        self.text = try secondNestedContainer.decode(String.self, forKey: .text)
    }
    
}
