import UIKit

final class DetailStoryCoordinator: Coordinator, CoordinatorInNavigation {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var detailStoryViewController: DetailStoryViewController!
    var parentCoordinator: LatestStoriesCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.present(detailStoryViewController, animated: true, completion: nil)
    }
    
    func didFinishDetailStory() {
        parentCoordinator?.childDidFinish(self)
    }
    
}
