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
    private var comicsRepository: ComicsRepository!
    private var seriesRepository: SeriesRepository!
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let rootScene = (scene as? UIWindowScene) else { return }
        
        charactersRepository = CharactersRepositoryImpl()
        comicsRepository = ComicsRepositoryImpl()
        seriesRepository = SeriesRepositoryImpl()
        
        let rootVC = MWTabBarController.newInstance(characterRepository: charactersRepository, comicsRepository: comicsRepository, seriesRepository: seriesRepository)
        let window = UIWindow(windowScene: rootScene)
        window.rootViewController = rootVC
        self.window = window
        window.makeKeyAndVisible()
    }
}

