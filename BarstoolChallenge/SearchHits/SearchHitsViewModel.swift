import Foundation

class SearchHitsViewModel {
    
    // MARK:- Properties
    var hits: [Hit] = [] {
        didSet {
            
        }
    }
    var error: Error?
    var coordinator: SearchHitsCoordinator?
    
    // MARK:- Initializer
    init(hits: [Hit]) {
        self.hits = hits
    }
    
    // MARK:- View model
    func getRowsCount() -> Int {
        return hits.count
    }
    
    func getHit(for indexPath: IndexPath) -> Hit {
        let hit = hits[indexPath.row]
        return hit
    }
    
    // MARK:- Methods
    func fetch(query: String, completion: @escaping() -> Void) {
        let searchStringUrl = "https://union.barstoolsports.com/v2/stories/search"
        let parameters: [String: String] = ["page": "1", "type": "standard_post", "limit": "20", "query": query]
        
        HitsService.shared.getHits(for: searchStringUrl, with: parameters) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let hits): self.hits = hits
            case .failure(let error): self.error = error
            }
            completion()
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let hit = hits[indexPath.item]
        _ = coordinator?.startDetailHit(hit: hit)
    }
    
}
