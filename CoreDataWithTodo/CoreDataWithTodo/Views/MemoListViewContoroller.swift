////
////  TodoListView.swift
////  CoreDataWithTodo
////
////  Created by 최승원 on 2022/09/22.
////
//
//import UIKit
//
//class MemoListViewController: UIView {
//    var memoManager: CoreDataManager
//
//    let tableView: UITableView = {
//        let view = UITableView()
//
//        return view
//    }()
//
//    override init(frame: CGRect, memo) {
//        configureUI()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func configureUI() {
//        self.addSubview(tableView)
//
//        tableView.register(MemoCell.self, forCellReuseIdentifier: MemoCell.cellId)
//        tableView.delegate = self
//        tableView.dataSource = self.tableView
//
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//
//        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
//        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
//
//        tableView.rowHeight = 120
//    }
//
//}
//
//extension MemoListViewController: UITableViewDelegate {
//
//}
//
//extension MemoListViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return memoManager.readMemoListFromCoreData().count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoCell", for: indexPath) as! MemoCell
//
//        let memoData = memoManager.readMemoListFromCoreData()
//        cell.memoData = memoData[indexPath.row]
//
//
//        print(memoData)
//        return cell
//    }
//}
//
//
