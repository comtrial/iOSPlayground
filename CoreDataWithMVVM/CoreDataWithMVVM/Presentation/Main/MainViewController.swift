//
//  ViewController.swift
//  CoreDataWithMVVM
//
//  Created by 최승원 on 2022/09/24.
//
import SwiftUI
import UIKit
import Combine

class MainViewController: UIViewController {
    let selfView = MemoListController()
    let viewModel: MemoListViewModelWithCombine
    var subscriber: Set<AnyCancellable> = .init()
    
    required init(viewModel: MemoListViewModelWithCombine) {
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
        viewModel.$meomoData.sink { memoDatas in
            self.selfView.tableView.reloadData()
//            print("memo \(memoDatas)")
        }.store(in: &subscriber)
        viewModel.loadMemoData()
    }
}

