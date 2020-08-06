import Foundation

class DetailHitViewModel {
    
    private var urlString: String
    var coordinator: DetailHitCoordinator?
    
    init(urlString: String) {
        self.urlString = urlString
    }
    
    var url: URL? {
        return URL(string: urlString)
    }
    
}
