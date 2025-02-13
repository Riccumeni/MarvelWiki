//
//  SceneDelegate.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 12/02/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let rootScene = (scene as? UIWindowScene) else { return }
        
        let tabBarController = UITabBarController()
        
        tabBarController.viewControllers = [
            CharactersVC.newInstance(title: "Characters", imageName: "person.2.fill"),
            ComicsVC.newInstance(title: "Comics", imageName: "book.closed.fill"),
            SeriesVC.newInstance(title: "Series", imageName: "books.vertical.fill")
        ]
        
        let rootVC = tabBarController
        let window = UIWindow(windowScene: rootScene)
        window.rootViewController = rootVC
        self.window = window
        window.makeKeyAndVisible()
    }
}

