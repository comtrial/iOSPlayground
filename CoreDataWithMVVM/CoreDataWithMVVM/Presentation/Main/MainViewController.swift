//
//  ViewController.swift
//  CoreDataWithMVVM
//
//  Created by 최승원 on 2022/09/24.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    let selfView = MemoListController()
    let viewModel: MemoListViewModel
    var subscriber: Set<AnyCancellable> = .init()
    
//    @ObservableObject var memoData: MemoData
    
    required init(viewModel: MemoListViewModel) {
        
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewdidload called")
        setupNVC()
        configureUI()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bind()
        self.selfView.tableView.reloadData()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(selfView)
        
        selfView.translatesAutoresizingMaskIntoConstraints = false
        selfView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        selfView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        selfView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        selfView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
    }
    
    func setupNVC() {
        self.navigationItem.title = "할 일 목록"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(nvcBtnClicked))
    }
    
    @objc func nvcBtnClicked() {
        DetailCoordinator(nvc: self.navigationController!).start()
    }

    // MARK: - DataBinding with ViewModel by Combine
    func bind() {
        viewModel.loadMemoData()
        viewModel.$meomoData.sink { [unowned self] memoDatas in
            print("memo \(memoDatas.count)")
            
        }.store(in: &subscriber)
    }
}

