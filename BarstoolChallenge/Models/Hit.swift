import Foundation

struct Hit: Codable {
    
    let title: String
    let imageURLStr: String?
    let authors: [String]
    let url: String
    var id: String?
    
    private enum RootCodingKeys: String, CodingKey {
        case title
        case imageURLStr = "image_sml"
        case authors
        case url
        case id = "objectID"
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        
        self.title = try valueContainer.decode(String.self, forKey: .title)
        self.imageURLStr = try valueContainer.decode(String.self, forKey: .imageURLStr)
        self.authors = try valueContainer.decode([String].self, forKey: .authors)
        self.url = try valueContainer.decode(String.self, forKey: .url)
        self.id = try valueContainer.decode(String?.self, forKey: .id)
    }
    
}

struct HitItems: Codable {
    let hits: [Hit]
}
