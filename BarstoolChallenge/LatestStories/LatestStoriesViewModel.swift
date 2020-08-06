import Foundation

class LatestStoriesViewModel {
    
    // MARK:- Properties
    var stories: [Story] = []
    var error: Error?
    var coordinator: LatestStoriesCoordinator?
    
    var isFetching: Bool = false
    var pageToLoad = 1
    
    // MARK:- Initializer
    init(stories: [Story]) {
        self.stories = stories
    }
    
    // MARK:- View model
    var iconName: String {
        return "splashicon"
    }
    
    // MARK:- Methods
    func fetch(afterRefresh: Bool = false, completion: @escaping() -> Void) {
        let latestStringUrl = "https://union.barstoolsports.com/v2/stories/latest"
        let pageStr = String(describing: pageToLoad)
        var parameters: [String: String] = [:]
        if !afterRefresh {
            parameters = ["page": pageStr, "type": "standard_post", "limit": "20"]
            pageToLoad += 1
            
        } else {
            parameters = ["page": "1", "type": "standard_post", "limit": "20"]
        }
        
        StoriesService.shared.getStories(for: latestStringUrl, with: parameters) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let loadedStories):
                if !afterRefresh {
                    self.stories += loadedStories
                } else {
                    self.stories = loadedStories
                }
                
            case .failure(let error): self.error = error
            }
            completion()
        }
    }
    
    func getItemsCount() -> Int {
        return stories.count
    }
    
    func getStory(for indexPath: IndexPath) -> Story {
        let story = stories[indexPath.item]
        return story
    }
    
    func fetchAfterPull(completion: @escaping() -> Void) {
        guard !isFetching else { return }
        fetch { [weak self] in
            guard let self = self else { return }
            self.isFetching = !self.isFetching
            completion()
        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let story = stories[indexPath.item]
        _ = coordinator?.startDetailStory(story: story)
    }
    
    func getDetailStoryVC(for indexPath: IndexPath) -> DetailStoryViewController? {
        let story = stories[indexPath.item]
        let detailStoryViewController = coordinator?.startDetailStory(noStartCall: true, story: story)
        return detailStoryViewController
    }
    
}
