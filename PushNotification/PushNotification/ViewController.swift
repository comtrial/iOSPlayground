//
//  ViewController.swift
//  PushNotification
//
//  Created by 최승원 on 2022/09/18.
//

import UIKit

class ViewController: UIViewController {
    private var text: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: UI setup
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(text)
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "Push Notification Playground"
        
        text.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        text.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

