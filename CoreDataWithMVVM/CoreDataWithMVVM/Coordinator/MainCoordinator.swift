
import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func start() {
        let memoViewModel = MemoListViewModelWithCombine()
        let rootViewController = MainViewController(viewModel: memoViewModel)
        navigationController?.setViewControllers([rootViewController], animated: true)
    }
}
