//
//  MarvelContentVC.swift
//  MarvelWiki
//
//  Created by Michelangelo Moncada on 20/02/25.
//

import UIKit

protocol MarvelContentVCDelegate: AnyObject {
    func loadContent(marvelContentType: MarvelContentType, completion: @escaping ([Any], Bool) -> Void)
}


class MarvelContentVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var marvelContentType: MarvelContentType!
    
    private var marvelContents: [Any] = []
    
    weak var delegate: MarvelContentVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(CharacterCVC.nib(), forCellWithReuseIdentifier: CharacterCVC.kReuseIdentifier)
        collectionView.register(ComicCVC.nib(), forCellWithReuseIdentifier: ComicCVC.kReuseIdentifier)
        collectionView.register(SeriesCVC.nib(), forCellWithReuseIdentifier: SeriesCVC.kReuseIdentifier)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        loadData()
    }
    
    // MARK: - Private Methods
    
    private func loadData() {
        collectionView.showLoadingIndicator(style: .large)
        delegate?.loadContent(marvelContentType: marvelContentType, completion: { result, isSuccessful in 
            self.collectionView.hideLoadingIndicator()
            
            self.marvelContents = result
            
            self.collectionView.reloadData()
        })
    }
    
}
    
    // MARK: - Extensions CV

    extension MarvelContentVC: UICollectionViewDelegate, UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return marvelContents.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            switch(self.marvelContentType) {
            case .characters:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCVC.kReuseIdentifier, for: indexPath) as! CharacterCVC
                let character = marvelContents[indexPath.row] as! Character
                cell.setupCell(name: character.name, imageUrl: URL(string: "\(character.thumbnail.path).\(character.thumbnail.urlExtension)"))
                return cell
            case .comics:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCVC.kReuseIdentifier, for: indexPath) as! ComicCVC
                let comic = marvelContents[indexPath.row] as! Comic
                cell.setupCell(imageUrl: URL(string: "\(comic.thumbnail.path).\(comic.thumbnail.urlExtension)"))
                return cell
            
            case .series:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeriesCVC.kReuseIdentifier, for: indexPath) as! SeriesCVC
                let series = marvelContents[indexPath.row] as! Series
                cell.configure(title: series.title)
                return cell
            
            default:
                return UICollectionViewCell()
            }
        }
    }

    extension MarvelContentVC: UICollectionViewDelegateFlowLayout {
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


