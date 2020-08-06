import Foundation

struct Story: Codable {
    
    let title: String
    let imageURLStr: String?
    let author: Author
    let url: String
    var brandName: String?
    var id: Int?
    var content: Content?
    
    private enum RootCodingKeys: String, CodingKey {
        case title
        case imageURLStr = "thumbnail"
        case author
        case url
        case brandName = "brand_name"
        case id
        
        enum NestedCodingKeys: String, CodingKey {
            case image = "desktop"
        }
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: RootCodingKeys.self)
        let nestedContainer = try valueContainer.nestedContainer(keyedBy: RootCodingKeys.NestedCodingKeys.self, forKey: .imageURLStr)
        
        self.title = try valueContainer.decode(String.self, forKey: .title)
        self.imageURLStr = try nestedContainer.decode(String.self, forKey: .image)
        self.author = try valueContainer.decode(Author.self, forKey: .author)
        self.url = try valueContainer.decode(String.self, forKey: .url)
        self.brandName = try valueContainer.decode(String?.self, forKey: .brandName)
        self.id = try valueContainer.decode(Int?.self, forKey: .id)
    }
    
}

struct Author: Codable {
    let name: String
}
