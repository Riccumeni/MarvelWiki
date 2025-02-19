//
//  HomeViewController.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 12/02/25.
//

import UIKit

protocol CharactersVCDelegate: AnyObject {
    func loadCharacters(completion: @escaping ([Character]) -> Void)
}

class CharactersVC: UIViewController {
    
    private var characters: [Character] = []
        
    weak var delegate: CharactersVCDelegate?
    
    // MARK: - Outlets
    
    @IBOutlet weak var characterCollectionView: UICollectionView!
    
    
    // MARK: - Lifecycle method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterCollectionView.delegate = self
        characterCollectionView.dataSource = self
        
        characterCollectionView.register(CharacterCVC.nib(), forCellWithReuseIdentifier: CharacterCVC.kReuseIdentifier)
        
        loadData()

    }
    
    // MARK: - Private Methods
        
    private func loadData() {
        delegate?.loadCharacters(completion: { result in
            self.characters = result
            self.characterCollectionView.reloadData()
        })
    }
}

// MARK: - Extensions CV

extension CharactersVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCVC.kReuseIdentifier, for: indexPath) as! CharacterCVC
        
        let character = characters[indexPath.row]
        
        cell.setupCell(name: character.name, imageUrl: URL(string: "\(character.thumbnail.path).\(character.thumbnail.urlExtension)"))
        
        return cell
    }
}

extension CharactersVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 3
        let padding: CGFloat = 10
        let totalSpacing = padding * (itemsPerRow - 1)
        let availableWidth = collectionView.frame.width - totalSpacing
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
}
