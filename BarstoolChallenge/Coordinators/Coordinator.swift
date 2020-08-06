import Foundation

protocol Coordinator: AnyObject {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}

protocol CoordinatorInNavigation: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func childDidFinish(_ childCoordinator: Coordinator)
}

extension CoordinatorInNavigation {
    func childDidFinish(_ childCoordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { (coordinator) -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
