//
//  ViewController.swift
//  BaseProject
//
//  Created by 최승원 on 2022/10/30.
//

import UIKit

class ViewController: UIViewController {
    let button =  UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
    }
    // MARK: UI setup
    func configureUI() {
        view.backgroundColor = .black
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Upload Playground", for: .normal)
        button
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectPhotoImageView.image = editedImage
            
            let imgUrl = info[UIImagePickerController.InfoKey.imageURL] as! URL
            let imgName = imgUrl.lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
            let localPath = documentDirectory?.appending(imgName)
            let data = editedImage.jpegData(compressionQuality: 0.5)! as NSData
            data.write(toFile: localPath!, atomically: true)
            let photoURL = URL.init(fileURLWithPath: localPath!)
            let partFilename = photoURL.lastPathComponent
            if let URLContent = try? Data(contentsOf: photoURL) {
                let partContent = URLContent
            }
            
            let resp = SessionManager.shared.just()?.post(
                "https://app.myta.io/api/1/file-upload",
                data: ["path": photoURL,
                       "filename": "testimage"],
                files: ["file": .url(photoURL, "image/jpeg")]
            )
            if (resp != nil && resp!.ok) {
                print("Made successful request")
            } else {
                print("Request failed :(((")
            }
        }
}

