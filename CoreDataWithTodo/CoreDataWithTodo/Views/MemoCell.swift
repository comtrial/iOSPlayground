//
//  MemoCell.swift
//  CoreDataWithTodo
//
//  Created by 최승원 on 2022/09/24.
//

import UIKit

class MemoCell: UITableViewCell {
    
    static let identifier = "CellId"
    
    private var memoTextLabel = UILabel()
    private var memoDateLabel = UILabel()
    
    
    // MARK: - tableview programmatically setup
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(memoTextLabel)
        
        memoTextLabel.translatesAutoresizingMaskIntoConstraints = false
        memoTextLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        memoTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        self.addSubview(memoDateLabel)
        
        memoDateLabel.translatesAutoresizingMaskIntoConstraints = false
        memoDateLabel.topAnchor.constraint(equalTo: memoTextLabel.bottomAnchor, constant: 8).isActive = true
        memoDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        memoDateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureUI(item: MemoData) {
        self.memoTextLabel.text = item.text
        self.memoDateLabel.text = item.dateString
    }
}
