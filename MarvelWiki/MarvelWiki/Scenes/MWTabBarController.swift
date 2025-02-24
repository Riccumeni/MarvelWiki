//
//  MWTabBarController.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 19/02/25.
//

import UIKit
import Foundation

class MWTabBarController: UITabBarController, MarvelContentVCDelegate {
        
    static func newInstance() -> MWTabBarController {
        let tabBarController = MWTabBarController()
        
        let firstVC = MarvelContentVC.newInstance(title: "Characters", imageName: "person.2.fill", marvelContentType: .characters)
        firstVC.delegate = tabBarController
        let navFirstVC = UINavigationController(rootViewController: firstVC)
        navFirstVC.setNavigationBarHidden(true, animated: true)
        
        let secondVC = MarvelContentVC.newInstance(title: "Comics", imageName: "book.closed.fill", marvelContentType: .comics)
        secondVC.delegate = tabBarController
        let navSecondVC = UINavigationController(rootViewController: secondVC)
        navSecondVC.setNavigationBarHidden(true, animated: true)
        
        let thirdVC = MarvelContentVC.newInstance(title: "Series", imageName: "books.vertical.fill", marvelContentType: .series)
        thirdVC.delegate = tabBarController
        let navThirdVC = UINavigationController(rootViewController: thirdVC)
        navThirdVC.setNavigationBarHidden(true, animated: true)
        
        tabBarController.viewControllers = [navFirstVC, navSecondVC, navThirdVC]
        
        return tabBarController
    }
    
    // MARK: - MarvelContentVCDelegate
    func loadContent(marvelContentType: MarvelContentType, completion: @escaping ([MarvelContent], Bool) -> Void) {
        var path = ""
        switch(marvelContentType) {
        case .characters:
            path = "/characters"
        case .comics:
            path = "/comics"
        case .series:
            path = "/series"
        }
        
        MWNetworkManager.shared.get(path: path) { result in
            switch result {
            case .success(let data):
                do {
                    let characterResponse = try JSONDecoder().decode(MarvelResponse.self, from: data)
                    completion(characterResponse.data.results, true)
                } catch {
                    completion([], false)
                }
            case .failure(_):
                completion([], false)
            }
        }
         
    }
}
