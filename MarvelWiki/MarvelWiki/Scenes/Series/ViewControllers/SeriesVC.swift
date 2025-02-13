//
//  SeriesVC.swift
//  MarvelWiki
//
//  Created by Alessandro Riccumeni on 13/02/25.
//

import UIKit

class SeriesVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var seriesCollectionView: UICollectionView!
    
    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()

        seriesCollectionView.delegate = self
        seriesCollectionView.dataSource = self
        
        seriesCollectionView.register(SeriesCVC.nib(), forCellWithReuseIdentifier: SeriesCVC.kReuseIdentifier)
    }
}

// MARK: - Extension CV

extension SeriesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeriesCVC.kReuseIdentifier, for: indexPath) as! SeriesCVC
        
        cell.configure(title: "Series \(indexPath.row)")
        
        return cell
    }
}

extension SeriesVC: UICollectionViewDelegateFlowLayout {
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
