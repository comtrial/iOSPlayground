//
//  ViewController.swift
//  WidgetWithDeeplink
//
//  Created by 최승원 on 2022/09/15.
//

import UIKit

class ViewController: UIViewController {
    var deeplinkParam: String
    private var text: UILabel = UILabel()
    
    init(deeplinkParam: String = "default") {
        self.deeplinkParam = deeplinkParam
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        print("dd")
        // Do any additional setup after loading the view.
    }
    
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(text)

        // MARK: No StoryBoard setup
        text.translatesAutoresizingMaskIntoConstraints = false

        // MARK: UI Component attribute setup
        text.text = "First \(self.deeplinkParam)"

        // MARK: UI Component Layout setup
        text.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        text.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

    }
    


}

