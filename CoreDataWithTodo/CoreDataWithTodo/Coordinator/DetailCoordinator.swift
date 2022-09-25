import UIKit

class DetailCoordinator: Coordinator {
    private var navigationController: UINavigationController
    
    init(nvc: UINavigationController) {
        self.navigationController = nvc
    }
    
    func start() {
        self.navigationController.pushViewController(DetailViewController(), animated: true)
    }
}
