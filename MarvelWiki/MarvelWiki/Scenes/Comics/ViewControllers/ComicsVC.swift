//
//  ComicsVC.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 13/02/25.
//

import UIKit

protocol ComicsVCDelegate: AnyObject {
    func loadComics(completion: @escaping ([Comic]) -> Void)
}

class ComicsVC: UIViewController {
    
    private var comics: [Comic] = []
        
    weak var delegate: ComicsVCDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    
    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        comicsCollectionView.delegate = self
        comicsCollectionView.dataSource = self
        
        comicsCollectionView.register(ComicCVC.nib(), forCellWithReuseIdentifier: ComicCVC.kReuseIdentifier)
        
        loadData()
    }
    
    // MARK: - Private methods
    private func loadData() {
        comicsCollectionView.showLoadingIndicator(style: .large)
        delegate?.loadComics(completion: { result in
            self.comicsCollectionView.hideLoadingIndicator()
            self.comics = result
            self.comicsCollectionView.reloadData()
        })
    }
}

// MARK: - Extensions CV

extension ComicsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCVC.kReuseIdentifier, for: indexPath) as! ComicCVC
        
        let comic = comics[indexPath.row]
        
        cell.setupCell(imageUrl: URL(string: comic.thumbnail.path + "." + comic.thumbnail.urlExtension))
        
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
