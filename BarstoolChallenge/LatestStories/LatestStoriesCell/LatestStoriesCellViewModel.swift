import Foundation

class LatestStoriesCellViewModel {
    
    // MARK:- Properties
    private var story: Story
    
    // MARK:- Initializer
    init(story: Story) {
        self.story = story
    }
    
    // MARK:- View model
    var title: String {
        return story.title
    }
    
    var author: String {
        return story.author.name
    }
    
    var brandName: String? {
        return story.brandName
    }
    
    func fetchImageData(completion: @escaping(Data) -> Void) {
        guard let imageURLStr = story.imageURLStr, let url = URL(string: imageURLStr) else { return }
        ImageDataService.shared.getImageDataHolder(withURL: url) { (dataHolder) in
            guard let dataHolder = dataHolder else { return }
            completion(dataHolder.data)
        }
    }
    
}

extension LatestStoriesCellViewModel: Identifiable {}
