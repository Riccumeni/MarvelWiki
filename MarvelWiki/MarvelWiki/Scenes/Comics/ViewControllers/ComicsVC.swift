//
//  ComicsVC.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 13/02/25.
//

import UIKit

class ComicsVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    
    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        comicsCollectionView.delegate = self
        comicsCollectionView.dataSource = self
        
        comicsCollectionView.register(ComicCVC.nib(), forCellWithReuseIdentifier: ComicCVC.kReuseIdentifier)
    }
}

// MARK: - Extensions CV

extension ComicsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCVC.kReuseIdentifier, for: indexPath) as! ComicCVC
        
        cell.setupCell(imageUrl: URL(string: "https://imgs.search.brave.com/_M6Iac1zTsCW3lVdRWMEUScctvoDHJoD7SMnWBhRcAs/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pLnJl/ZGQuaXQvNGZ1YTV3/eG40OGZlMS5qcGVn"))
        
        return cell
    }
}

extension ComicsVC: UICollectionViewDelegateFlowLayout {
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
