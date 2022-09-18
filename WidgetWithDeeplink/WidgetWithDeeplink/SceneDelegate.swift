//
//  SceneDelegate.swift
//  WidgetWithDeeplink
//
//  Created by 최승원 on 2022/09/15.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowscene = scene as? UIWindowScene {
          
            let window = UIWindow(windowScene: windowscene)
            window.rootViewController = ViewController()
            self.window = window
            window.makeKeyAndVisible()
            
        } else { return }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        print("he")
        guard let url = URLContexts.first?.url else { return }
        
        // 해당 scheme과 host를 가지고 있는지 파악
        guard url.scheme == "Deeplink-test", url.host == "widget" else { return }

        // 원하는 query parameter가 있는지 파악
        let urlString = url.absoluteString
        guard urlString.contains("mode") else { return }

        let components = URLComponents(string: url.absoluteString)
        let urlQueryItems = components?.queryItems ?? [] // [name=jake]

        var dictionaryData = [String: String]()
        urlQueryItems.forEach { dictionaryData[$0.name] = $0.value }

        guard let mode = dictionaryData["mode"] else { return }

        print("작성 모드 = \(mode)")

        print(url)
        
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = ViewController(deeplinkParam: mode)
            self.window = window
            window.makeKeyAndVisible()
            
        } else { return }
    }
}

