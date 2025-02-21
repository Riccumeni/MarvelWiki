//
//  MWTabBarController.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 19/02/25.
//

import UIKit
import Foundation

class MWTabBarController: UITabBarController, MarvelContentVCDelegate {
    
    private var charactersRepository: CharactersRepository!
    private var comicsRepository: ComicsRepository!
    private var seriesRepository: SeriesRepository!
    
    static func newInstance(characterRepository: CharactersRepository, comicsRepository: ComicsRepository, seriesRepository: SeriesRepository) -> MWTabBarController {
        let tabBarController = MWTabBarController()
        
        tabBarController.charactersRepository = characterRepository
        tabBarController.comicsRepository = comicsRepository
        tabBarController.seriesRepository = seriesRepository
        
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
    
    // MARK: - Private Methods
    
    private func loadCharacters(completion: @escaping ([Character], Bool) -> Void) {
        charactersRepository.getCharacters(filters: [:]) { result in
            switch result {
                case .success(let characters):
                completion(characters.data.results, true)
            case .failure(let error):
                print("Error: \(error)")
                completion([], false)
            }
        }
    }
    
    
    
    private func loadComics(completion: @escaping ([Comic], Bool) -> Void) {
        comicsRepository.getComics(filters: [:]) { result in
            switch result {
                case .success(let characters):
                completion(characters.data.results, true)
            case .failure(let error):
                print("Error: \(error)")
                completion([], false)
            }
        }
    }
    
    
    private func loadSeries(completion: @escaping ([Series], Bool) -> Void) {
        seriesRepository.getSeries(filters: [:]) { result in
            switch result {
                case .success(let series):
                completion(series.data.results, true)
            case .failure(let error):
                print("Error: \(error)")
                completion([], false)
            }
        }
    }
    
    // MARK: - MarvelContentVCDelegate
    func loadContent(marvelContentType: MarvelContentType, completion: @escaping ([Any], Bool) -> Void) {
        switch(marvelContentType) {
        case .characters:
            loadCharacters(completion: completion)
        case .comics:
            loadComics(completion: completion)
        case .series:
            loadSeries(completion: completion)
        }
    }
}
