import UIKit

class DetailCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    init(nvc: UINavigationController) {
        self.navigationController = nvc
    }
    
    func start() {
        let memoViewModel = MemoListViewModelWithCombine()
        self.navigationController?.pushViewController(DetailViewController(viewModel: memoViewModel), animated: true)
    }
}
