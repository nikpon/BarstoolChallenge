import Foundation

class SearchHitsCellViewModel {
    
    // MARK:- Properties
    private var hit: Hit
    
    // MARK:- Initializer
    init(hit: Hit) {
        self.hit = hit
    }
    
    // MARK:- View model
    var title: String {
        return hit.title
    }
    
    var author: String? {
        return hit.authors.first
    }
    
    func fetchImageData(completion: @escaping(Data) -> Void) {
        guard let imageURLStr = hit.imageURLStr, let url = URL(string: imageURLStr) else { return }
        ImageDataService.shared.getImageDataHolder(withURL: url) { (dataHolder) in
            guard let dataHolder = dataHolder else { return }
            completion(dataHolder.data)
        }
    }
    
}

extension SearchHitsCellViewModel: Identifiable {}
