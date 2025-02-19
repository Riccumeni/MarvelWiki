//
//  MWTabBarController.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 19/02/25.
//

import UIKit
import Foundation

class MWTabBarController: UITabBarController, CharactersVCDelegate {
    
    private var charactersRepository: CharactersRepository!
    
    static func newInstance(characterRepository: CharactersRepository) -> MWTabBarController {
        let tabBarController = MWTabBarController()
        
        tabBarController.charactersRepository = characterRepository
        
        let firstVC = CharactersVC.newInstance(title: "Characters", imageName: "person.2.fill") as! CharactersVC
        firstVC.delegate = tabBarController
        let navFirstVC = UINavigationController(rootViewController: firstVC)
        
        let secondVC = ComicsVC.newInstance(title: "Comics", imageName: "book.closed.fill")
        let navSecondVC = UINavigationController(rootViewController: secondVC)
        
        let thirdVC = SeriesVC.newInstance(title: "Series", imageName: "books.vertical.fill")
        let navThirdVC = UINavigationController(rootViewController: thirdVC)
        
        tabBarController.viewControllers = [navFirstVC, navSecondVC, navThirdVC]
        
        return tabBarController
    }
    
    // MARK: - CharactersVCDelegate
    
    func loadCharacters(completion: @escaping ([Character]) -> Void) {
        charactersRepository.getCharacters(filters: [:]) { result in
            switch result {
                case .success(let characters):
                completion(characters.data.results)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
