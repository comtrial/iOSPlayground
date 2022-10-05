//
//  SceneDelegate.swift
//  CoreDataWithMVVM
//
//  Created by 최승원 on 2022/09/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let nvc = UINavigationController()
        
        let coordinator = MainCoordinator()
        coordinator.navigationController = nvc
        coordinator.start()
        
        window?.rootViewController = nvc
        window?.makeKeyAndVisible()
    }
}

