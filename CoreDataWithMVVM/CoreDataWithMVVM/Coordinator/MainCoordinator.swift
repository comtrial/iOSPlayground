
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func start() {
        let memoViewModel = MemoListViewModel()
        let rootViewController = MainViewController(viewModel: memoViewModel)
        navigationController?.setViewControllers([rootViewController], animated: true)
    }
}
