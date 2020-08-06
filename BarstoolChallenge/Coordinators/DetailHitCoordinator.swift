import UIKit

final class DetailHitCoordinator: Coordinator, CoordinatorInNavigation {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var detailHitViewController: DetailHitViewController!
    var parentCoordinator: SearchHitsCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.present(detailHitViewController, animated: true, completion: nil)
    }
    
    func didFinishDetailStory() {
        parentCoordinator?.childDidFinish(self)
    }
    
}
