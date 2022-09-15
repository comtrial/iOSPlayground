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

        print(url)
        
        
        if let windowScene = scene as? UIWindowScene {
          
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = ViewController(deeplinkParam: "From Deeplink")
            self.window = window
            window.makeKeyAndVisible()
            
        } else { return }
    }
}

