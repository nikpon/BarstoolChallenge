import Foundation

class DetailStoryViewModel {
    
    // MARK:- Properties
    private var story: Story
    var coordinator: DetailStoryCoordinator?
    
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
    
    func fetchContentText(completion: @escaping(NSAttributedString) -> Void) {
        guard let storyId = story.id else { return }
        ContentService.shared.getContent(for: String(describing: storyId)) { (result) in
            switch result {
            case .success(let content): completion(content)
            case .failure(let error):
                if let error = error.errorDescription {
                    fatalError(error)
                }
            }
        }
    }
    
    // MARK:- Methods
    func startDetailStoryVC() {
        coordinator?.start()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinishDetailStory()
    }
    
}
