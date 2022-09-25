import UIKit

class ViewController: UIViewController {
    
    private var text: UILabel = UILabel()
    private var button: UIButton = UIButton()
    private var tableview: UITableView = UITableView()
    
    
    let memoManager = CoreDataManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNVC()
        configureUI()
        
        let memoData = memoManager.readMemoListFromCoreData()
        print(memoData)
    }

    func configureUI() {
        view.backgroundColor = .white
        drawTableView()
    }
    
    func setupNVC() {
        self.navigationItem.title = "할 일 목록"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                                 style: .plain,
                                                                 target: self,
                                                                 action: #selector(nvcBtnClicked))
    }
    
    @objc func nvcBtnClicked() {
        DetailCoordinator(nvc: self.navigationController!).start()
    }
    
    
    func drawTableView() {
        view.addSubview(tableview)
        
        tableview.translatesAutoresizingMaskIntoConstraints = false
        
        tableview.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableview.register(MemoCell.self, forCellReuseIdentifier: MemoCell.identifier)
        tableview.delegate = self
        tableview.dataSource = self
        
    }
}

extension ViewController: UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoManager.readMemoListFromCoreData().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemoCell.identifier, for: indexPath) as! MemoCell

        let memoData = memoManager.readMemoListFromCoreData()
        let item = memoData[indexPath.row]
        
        cell.configureUI(item: item)
        return cell
    }
}
