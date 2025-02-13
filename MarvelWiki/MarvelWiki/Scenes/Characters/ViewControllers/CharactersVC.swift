//
//  HomeViewController.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 12/02/25.
//

import UIKit

class CharactersVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var characterCollectionView: UICollectionView!
    
    
    // MARK: - Lifecycle method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        characterCollectionView.delegate = self
        characterCollectionView.dataSource = self
        
        characterCollectionView.register(CharacterCVC.nib(), forCellWithReuseIdentifier: CharacterCVC.kReuseIdenitifier)

    }
}

// MARK: - CVDelegate, CVDataSource

extension CharactersVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCVC.kReuseIdenitifier, for: indexPath) as! CharacterCVC
        
        cell.setupCell(name: "Hero \(indexPath.row)", imageUrl: URL(string: "https://imgs.search.brave.com/baAy3T2nKSmMAD3tFIpO97mrLPf1vgBEaH-ZE1vrsqw/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly93d3cu/cGNnYW1lc24uY29t/L3dwLWNvbnRlbnQv/c2l0ZXMvcGNnYW1l/c24vMjAyNC8xMi9t/YXJ2ZWwtcml2YWxz/LWNoYXJhY3RlcnMt/bW9vbi1rbmlnaHQt/LTU1MHgzMDkuanBn"))
        
        return cell
    }
}
