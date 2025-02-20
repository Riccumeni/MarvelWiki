//
//  MWTabBarController.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 19/02/25.
//

import UIKit
import Foundation

class MWTabBarController: UITabBarController, CharactersVCDelegate, ComicsVCDelegate, SeriesVCDelegate {
    
    private var charactersRepository: CharactersRepository!
    private var comicsRepository: ComicsRepository!
    private var seriesRepository: SeriesRepository!
    
    static func newInstance(characterRepository: CharactersRepository, comicsRepository: ComicsRepository, seriesRepository: SeriesRepository) -> MWTabBarController {
        let tabBarController = MWTabBarController()
        
        tabBarController.charactersRepository = characterRepository
        tabBarController.comicsRepository = comicsRepository
        tabBarController.seriesRepository = seriesRepository
        
        let firstVC = CharactersVC.newInstance(title: "Characters", imageName: "person.2.fill") as! CharactersVC
        firstVC.delegate = tabBarController
        let navFirstVC = UINavigationController(rootViewController: firstVC)
        navFirstVC.setNavigationBarHidden(true, animated: true)
        
        let secondVC = ComicsVC.newInstance(title: "Comics", imageName: "book.closed.fill") as! ComicsVC
        secondVC.delegate = tabBarController
        let navSecondVC = UINavigationController(rootViewController: secondVC)
        navSecondVC.setNavigationBarHidden(true, animated: true)
        
        let thirdVC = SeriesVC.newInstance(title: "Series", imageName: "books.vertical.fill") as! SeriesVC
        thirdVC.delegate = tabBarController
        let navThirdVC = UINavigationController(rootViewController: thirdVC)
        navThirdVC.setNavigationBarHidden(true, animated: true)
        
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
    
    // MARK: - ComicsVCDelegate
    
    func loadComics(completion: @escaping ([Comic]) -> Void) {
        comicsRepository.getComics(filters: [:]) { result in
            switch result {
                case .success(let characters):
                completion(characters.data.results)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    // MARK: - SeriesVCDelegate
    
    func loadSeries(completion: @escaping ([Series]) -> Void) {
        seriesRepository.getSeries(filters: [:]) { result in
            switch result {
                case .success(let series):
                completion(series.data.results)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}
