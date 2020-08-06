import UIKit

final class LatestStoriesCoordinator: Coordinator, CoordinatorInNavigation {
 
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let latestStoriesViewModel = LatestStoriesViewModel(stories: [Story]())
        latestStoriesViewModel.coordinator = self
        let latestStoriesViewController = LatestStoriesViewController()
        latestStoriesViewController.viewModel = latestStoriesViewModel
        
        navigationController.setViewControllers([latestStoriesViewController], animated: false)
    }
    
    func startDetailStory(noStartCall: Bool = false, story: Story) -> DetailStoryViewController? {
        let detailStoryViewModel = DetailStoryViewModel(story: story)
        let detailStoryViewController = DetailStoryViewController()
        detailStoryViewController.viewModel = detailStoryViewModel
        
        let detailStoryCoordinator = DetailStoryCoordinator(navigationController: navigationController)
        detailStoryCoordinator.parentCoordinator = self
        detailStoryViewModel.coordinator = detailStoryCoordinator
        detailStoryCoordinator.detailStoryViewController = detailStoryViewController
        childCoordinators.append(detailStoryCoordinator)

        if !noStartCall {
            detailStoryCoordinator.start()
            return nil
        }
        return detailStoryViewController
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { (coordinator) -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }

}
