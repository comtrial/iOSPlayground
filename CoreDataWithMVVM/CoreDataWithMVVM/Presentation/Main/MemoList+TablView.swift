//
//  MemoList+TablView.swift
//  CoreDataWithMVVM
//
//  Created by 최승원 on 2022/09/25.
//

import UIKit

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.meomoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemoCell.identifier, for: indexPath) as! MemoCell
        let item = viewModel.meomoData[indexPath.row]
        cell.configureUI(item: item)
        
        return cell
    }
}
