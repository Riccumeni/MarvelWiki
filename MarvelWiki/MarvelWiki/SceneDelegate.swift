//
//  SceneDelegate.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 12/02/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private var charactersRepository: CharactersRepository!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let rootScene = (scene as? UIWindowScene) else { return }
        
        charactersRepository = CharactersRepositoryImpl()
        
        let rootVC = MWTabBarController.newInstance(characterRepository: charactersRepository)
        let window = UIWindow(windowScene: rootScene)
        window.rootViewController = rootVC
        self.window = window
        window.makeKeyAndVisible()
    }
}

