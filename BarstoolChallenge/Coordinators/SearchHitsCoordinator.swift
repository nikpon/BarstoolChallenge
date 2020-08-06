import UIKit

final class SearchHitsCoordinator: Coordinator, CoordinatorInNavigation {
    
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchStoriesViewModel = SearchHitsViewModel(hits: [Hit]())
        searchStoriesViewModel.coordinator = self
        let searchStoriesViewController = SearchHitsViewController()
        searchStoriesViewController.viewModel = searchStoriesViewModel
        
        navigationController.setViewControllers([searchStoriesViewController], animated: false)
    }
    
    func startDetailHit(hit: Hit) -> DetailHitViewController? {
        guard let imageURLStr = hit.imageURLStr else { return nil }
        
        let detailHitViewModel = DetailHitViewModel(urlString: imageURLStr)
        let detailHitViewController = DetailHitViewController()
        detailHitViewController.viewModel = detailHitViewModel
        
        let detailHitCoordinator = DetailHitCoordinator(navigationController: navigationController)
        detailHitCoordinator.parentCoordinator = self
        detailHitViewModel.coordinator = detailHitCoordinator
        detailHitCoordinator.detailHitViewController = detailHitViewController
        childCoordinators.append(detailHitCoordinator)
        detailHitCoordinator.start()
        
        return detailHitViewController
    }
    
}
