//
//  BaseView.swift
//  CoreDataWithTodo
//
//  Created by 최승원 on 2022/09/22.
//

import Foundation
import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        
    }
}
