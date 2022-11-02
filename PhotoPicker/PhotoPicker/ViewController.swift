//
//  ViewController.swift
//  PhotoPicker
//
//  Created by 최승원 on 2022/11/02.
//

import UIKit

class ViewController: UIViewController {
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        // Do any additional setup after loading the view.
    }

    func configureUI() {
        view.backgroundColor = .white
        
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 180),
            imageView.widthAnchor.constraint(equalToConstant: 180)
        ])
        
        let button = UIButton()
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(photoButtonClicked), for: .touchDown)
        button.setTitle("photo picker", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 48)
            
        ])
    }
    
    @objc func photoButtonClicked() {
        print("d")
        presentPickerView()
    }
}

import PhotosUI

extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        
//        dismiss(animated: true, completion: nil)
        for item in results {
            item.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                
                if let image = image as? UIImage {
                    print(image)
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                    
                }
            }
        }
    }
    
    
    func presentPickerView() {
        var configuration: PHPickerConfiguration = PHPickerConfiguration()
        configuration.filter = PHPickerFilter.images
        configuration.selectionLimit = 3
        
        var picker: PHPickerViewController = PHPickerViewController(configuration: configuration)
        
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
}

