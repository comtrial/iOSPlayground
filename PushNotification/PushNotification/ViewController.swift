//
//  ViewController.swift
//  PushNotification
//
//  Created by 최승원 on 2022/09/18.
//

import UIKit

class ViewController: UIViewController {
    private var text: UILabel = UILabel()
    // MARK: 추가
    let userNotiCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        // MARK: Notification setup
        requestAutNoti()
        requestSendNoti(seconds: 2)
        requestSendNoti(seconds: 5)
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
    
    // MARK: 사용자에게 알림 권한 요처
    func requestAutNoti() {
        let notiAuthOptions = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
        
        userNotiCenter.requestAuthorization(options: notiAuthOptions) { (success, err) in
            if let err = err {
                print(#function, err)
            }
        }
    }
    
    // MARK: 알림 전송
    func requestSendNoti(seconds: Double) {
        let notiContent = UNMutableNotificationContent()
        
        notiContent.title = "알림 title"
        notiContent.body = "알림 body"
        notiContent.userInfo = ["targetScene": "splash"] // 푸시 받을때 오는 데이터
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: notiContent,
            trigger: trigger
        )
        
        userNotiCenter.add(request) { (err) in
            print(#function, err)
        }
    }
}

