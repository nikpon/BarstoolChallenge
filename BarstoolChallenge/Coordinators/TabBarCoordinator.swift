import UIKit

final class TabBarCoordinator: Coordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
        configureNavigationBar()
    }
    
    func start() {
        let tabBarViewModel = TabBarViewModel()
        let tabBarController = TabBarController()
        tabBarController.viewModel = tabBarViewModel
        tabBarController.viewModel.coordinator = self
        
        let latestStoriesNavigationController = UINavigationController()
        latestStoriesNavigationController.tabBarItem = UITabBarItem(title: "Latest", image: UIImage(systemName: "clock"), tag: 0)
        let latestStoriesCoordinator = LatestStoriesCoordinator(navigationController: latestStoriesNavigationController)
        
        let searchStoriesNavigationController = UINavigationController()
        searchStoriesNavigationController.tabBarItem = UITabBarItem(
            tabBarSystemItem: .search, tag: 1)
        let searchStoriesCoordinator = SearchHitsCoordinator(navigationController: searchStoriesNavigationController)
        
        tabBarController.viewControllers = [latestStoriesNavigationController, searchStoriesNavigationController]
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
        
        coordinate(to: latestStoriesCoordinator)
        coordinate(to: searchStoriesCoordinator)
    }
    
    func configureNavigationBar() {
        UINavigationBar.appearance().barTintColor = UIColor.white
    }
    
}
